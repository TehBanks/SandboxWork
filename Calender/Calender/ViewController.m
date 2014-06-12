//
//  ViewController.m
//  Calender
//
//  Created by Kyle Banks on 5/29/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)ResizeFrame
{
    float sizeOfContent = 0;
    UIView *lLast = [ScrollView.subviews lastObject];
    NSInteger wd = lLast.frame.origin.y;
    NSInteger ht = lLast.frame.size.height;
    
    sizeOfContent = wd+ht;
    
    ScrollView.contentSize = CGSizeMake(ScrollView.frame.size.width, sizeOfContent);
}

-(void)DrawGrid
{
    [[ScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange r = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:theDate];
    NSDateComponents *weekdayComponents =[c components:NSWeekdayCalendarUnit fromDate:theDate];
    NSInteger firstDay = [weekdayComponents weekday];
    
    NSInteger length = r.length + firstDay;
    NSInteger date = 1;
    
    NSLog(@"%i %i",firstDay,length);
    
    for(int x= 0; x < 6; x++)
    {
        for(int y=0; y < 7; y++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self action:@selector(DateClick :) forControlEvents:UIControlEventTouchDown];
            button.frame =  CGRectMake(y*40, x*40, 40, 40);
            
            if(((7*x)+1)+(y+1) > firstDay && (((7*x)+1)+(y)) < length)
            {
                NSString *theTitle = [NSString stringWithFormat:@"%i", date];
                [button setTitle:theTitle forState:UIControlStateNormal];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                 date++;
            }
            else
            {
                [button setTitle:@"X" forState:UIControlStateNormal];
                button.enabled = NO;
            
            }
            
            
            [ScrollView addSubview:button];
            
            
        }
    }
}

-(void)UpdateHeaderLabels
{
    NSCalendar *CurrCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [CurrCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [comp setDay:1];
    

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MMMM - YYYY"];
    Display.text = [dateFormatter stringFromDate:theDate];
    
}

-(IBAction)NextMonthClick:(id)sender
{

    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    theDate = [calendar dateByAddingComponents:dateComponents toDate:theDate options:0];
    
    
    [self UpdateHeaderLabels];
    [self DrawGrid];
    

}

-(IBAction)PreviousMonthClick:(id)sender
{
    
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    theDate = [calendar dateByAddingComponents:dateComponents toDate:theDate options:0];
    
    
    [self UpdateHeaderLabels];
    [self DrawGrid];
    
    
}

-(IBAction)DateClick:(id)sender
{
    UIButton *btn =  (UIButton *) sender;
    NSLog(@"Button Click!");
    if([btn titleColorForState:UIControlStateNormal] == [UIColor redColor])
    {
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    else
    {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }


    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSCalendar *CurrCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [CurrCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    [comp setDay:1];
    
     theDate = [CurrCalendar dateFromComponents:comp];
    [self DrawGrid];
    [self UpdateHeaderLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
