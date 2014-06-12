//
//  ViewController.h
//  Calender
//
//  Created by Kyle Banks on 5/29/14.
//
//

#import <UIKit/UIKit.h>

NSDate *theDate;

@interface ViewController : UIViewController
{
    IBOutlet UIScrollView *ScrollView;
    IBOutlet UILabel *Display;
}

-(void)ResizeFrame;
-(void)DrawGrid;
-(void)UpdateHeaderLabels;
-(IBAction)DateClick:(id)sender;
-(IBAction)NextMonthClick:(id)sender;
-(IBAction)PreviousMonthClick:(id)sender;
@end
