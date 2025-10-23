//
//  ViewController.h
//  Fancy Text Creator Application
//
//  Created by Tharsikan Sathasivam on 2025-10-23.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    CGFloat fontSize;
    BOOL state;
    
}

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIButton *shadowButton;

@property (weak, nonatomic) IBOutlet UITextField *textField;




- (IBAction)dismissKeyboard:(id)sender;

- (IBAction)red:(id)sender;
- (IBAction)blue:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)font1:(id)sender;
- (IBAction)font2:(id)sender;
- (IBAction)font3:(id)sender;
- (IBAction)font4:(id)sender;
- (IBAction)shadowButton:(id)sender;
- (IBAction)small:(id)sender;
- (IBAction)large:(id)sender;
- (IBAction)meduim:(id)sender;


@end

