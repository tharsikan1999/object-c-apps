#import "AppDelegate.h"
#import "Cryptlex/LexActivator.h"

@interface AppDelegate () <NSTableViewDataSource, NSTableViewDelegate>

@property (strong) NSWindow *window;
@property (strong) NSTextField *taskInput;
@property (strong) NSButton *addButton;
@property (strong) NSTableView *tableView;
@property (strong) NSMutableArray *tasks;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // 🔹 Prepare Cryptlex data directory (user-level)
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *appSupport = (paths.count > 0) ? paths[0] : NSTemporaryDirectory();
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier] ?: @"com.personal.todo";
    NSString *lexDataDir = [appSupport stringByAppendingPathComponent:bundleID];

    if (![[NSFileManager defaultManager] fileExistsAtPath:lexDataDir]) {
        NSError *dirError = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:lexDataDir
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&dirError];
        if (dirError) {
            NSLog(@"⚠️ Failed to create data directory %@: %@", lexDataDir, dirError);
        }
    }

    SetDataDirectory([lexDataDir UTF8String]);

    // 🔹 Load product data
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Product_Todo" ofType:@"dat"];
    if (!filePath) {
        [self showLicenseError:@"Product data file missing."];
        return;
    }

    NSString *productData = [NSString stringWithContentsOfFile:filePath
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
    if (!productData) {
        [self showLicenseError:@"Failed to read product data."];
        return;
    }

    if (SetProductData([productData UTF8String]) != LA_OK) {
        [self showLicenseError:@"Product data error"];
        return;
    }

    // 🔹 Set Product ID (user-level to avoid admin permissions)
    enum LexStatusCodes status = SetProductId("019a2e73-1f14-7ae7-bfa8-3653d1ef6ec2", LA_USER);
    if (status != LA_OK) {
        [self showLicenseError:[NSString stringWithFormat:@"Product ID error: %d", status]];
        return;
    }

    // 🔹 Check license
    status = IsLicenseGenuine();
    if (status == LA_OK) {
        NSLog(@"✅ License is genuine. Launching app...");
        [self showMainWindow];
    } else {
        NSLog(@"🔐 License not found or invalid. Prompting activation...");
        [self promptForLicenseActivation];
    }
}

#pragma mark - 🔑 License Activation

- (void)promptForLicenseActivation {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"License Required";
    alert.informativeText = @"Please enter your Cryptlex license key to activate the app.";
    [alert addButtonWithTitle:@"Activate"];
    [alert addButtonWithTitle:@"Exit"];

    NSTextField *inputField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 240, 24)];
    alert.accessoryView = inputField;

    NSModalResponse response = [alert runModal];
    
    NSURL *url = [NSURL URLWithString:@"https://api.cryptlex.com/v3"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:5];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showLicenseError:@"No internet connection. Please check your network."];
            });
        }
    }];
    [task resume];


    if (response == NSAlertFirstButtonReturn) {
        NSString *licenseKey = inputField.stringValue;
        if (licenseKey.length == 0) {
            [self showLicenseError:@"License key cannot be empty."];
            return;
        }

        if (SetLicenseKey([licenseKey UTF8String]) != LA_OK) {
            [self showLicenseError:@"Failed to set license key"];
            return;
        }

        enum LexStatusCodes status = ActivateLicense();
        printf("ActivateLicense status: %d\n", status);
        if (status == LA_OK || status == LA_EXPIRED || status == LA_SUSPENDED) {
            NSLog(@"🎉 License activated successfully!");
            [self showMainWindow];
        } else {
            [self showLicenseError:[NSString stringWithFormat:@"License activation failed: %d", status]];
        }
    } else {
        [NSApp terminate:nil];
    }
}

- (void)showLicenseError:(NSString *)message {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"License Error";
    alert.informativeText = message;
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
    [NSApp terminate:nil];
}

#pragma mark - 🪟 Main Window

- (void)showMainWindow {
    self.tasks = [NSMutableArray array];

    self.window = [[NSWindow alloc] initWithContentRect:NSMakeRect(100, 100, 400, 400)
                                              styleMask:(NSWindowStyleMaskTitled |
                                                         NSWindowStyleMaskClosable |
                                                         NSWindowStyleMaskResizable)
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];

    self.window.title = @"To-Do App (Licensed)";
    [self.window makeKeyAndOrderFront:nil];

    // Task input
    self.taskInput = [[NSTextField alloc] initWithFrame:NSMakeRect(20, 350, 260, 30)];
    [self.window.contentView addSubview:self.taskInput];

    // Add button
    self.addButton = [[NSButton alloc] initWithFrame:NSMakeRect(290, 350, 80, 30)];
    [self.addButton setTitle:@"Add Task"];
    [self.addButton setTarget:self];
    [self.addButton setAction:@selector(addTask)];
    [self.window.contentView addSubview:self.addButton];

    // Table view
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(20, 20, 360, 320)];
    self.tableView = [[NSTableView alloc] initWithFrame:scrollView.bounds];

    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:@"TaskColumn"];
    column.title = @"Tasks";
    column.width = 360;
    [self.tableView addTableColumn:column];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    scrollView.documentView = self.tableView;
    scrollView.hasVerticalScroller = YES;
    [self.window.contentView addSubview:scrollView];
}

#pragma mark - ➕ Add Task

- (void)addTask {
    NSString *task = self.taskInput.stringValue;
    if (task.length > 0) {
        [self.tasks addObject:task];
        [self.tableView reloadData];
        self.taskInput.stringValue = @"";
    }
}

#pragma mark - 📋 Table View

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.tasks.count;
}

- (nullable NSView *)tableView:(NSTableView *)tableView
           viewForTableColumn:(NSTableColumn *)tableColumn
                          row:(NSInteger)row {
    NSTextField *cell = [tableView makeViewWithIdentifier:@"TaskCell" owner:self];
    if (!cell) {
        cell = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, tableColumn.width, 30)];
        cell.bezeled = NO;
        cell.editable = NO;
        cell.drawsBackground = NO;
        cell.identifier = @"TaskCell";
    }
    cell.stringValue = self.tasks[row];
    return cell;
}

@end
