//
//  ViewController.h
//  TemperatureCalculator
//
//  Created by Tharsikan Sathasivam on 2025-10-23.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UILabel *enterLabel;


- (IBAction)convert:(id)sender;
- (IBAction)switchConversion:(id)sender;




@end

