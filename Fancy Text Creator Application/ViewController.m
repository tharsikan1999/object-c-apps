//
//  ViewController.m
//  FancyTextCreator
//
//  Created by Tharsikan Sathasivam on 2025-10-23.

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    state = false;
    fontSize = 33;
}


- (IBAction)dismissKeyboard:(id)sender {
    
    self.label.text = self.textField.text;
    [self resignFirstResponder];
    
}

- (IBAction)red:(id)sender {
    
    self.label.textColor = [UIColor redColor];
}

- (IBAction)blue:(id)sender {
    
    self.label.textColor = [UIColor blueColor];
}

- (IBAction)green:(id)sender {
    
    self.label.textColor = [UIColor colorWithRed:37.0/255.0 green:255.0/255.0 blue:176.0/255.0 alpha:1.0];
}

- (IBAction)font1:(id)sender {
    
    [self.label setFont:[UIFont fontWithName:@"Blacksword" size:fontSize]];
}

- (IBAction)font2:(id)sender {
    
    [self.label setFont:[UIFont fontWithName:@"LemonMilk" size:fontSize]];
}

- (IBAction)font3:(id)sender {
    
    [self.label setFont:[UIFont fontWithName:@"Moon Flower" size:fontSize]];
}

- (IBAction)font4:(id)sender {
    
    [self.label setFont:[UIFont fontWithName:@"SugarstyleMillenial-Regular" size:fontSize]];
}



- (IBAction)small:(id)sender {
    
    fontSize = 33;
    self.label.font = [self.label.font fontWithSize:fontSize];
    
}

- (IBAction)shadowButton:(id)sender {
    
    if (state == true) {
        
        self.label.layer.shadowOpacity = 0.0;
        
        state = false;
        
        [self.shadowButton setTitle:@"Add Shadow" forState:UIControlStateNormal];
        
    } else {
        
        self.label.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.label.layer.shadowOpacity = 0.25;
        self.label.layer.shadowRadius = 2.0f;
        self.label.layer.shadowOffset = CGSizeMake(2, 2);
        
        state = true;
        
        [self.shadowButton setTitle:@"Remove Shadow" forState:UIControlStateNormal];
        
    }
    
}


- (IBAction)meduim:(id)sender {
    fontSize = 50;
    self.label.font = [self.label.font fontWithSize:fontSize];
}

- (IBAction)large:(id)sender {
    
    fontSize = 100;
    self.label.font = [self.label.font fontWithSize:fontSize];
}
@end
