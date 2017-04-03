//
//  ViewController.m
//  ETimePicker
//
//  Created by measta on 2017/4/3.
//  Copyright © 2017年 meast. All rights reserved.
//

#import "ViewController.h"
#import "ETimePicker.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *lb;

@property (nonatomic, strong) ETimePicker *pickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.btn addTarget:self action:@selector(actBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    /*
    CGRect rect = CGRectMake(0, 200, 200, 100);
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:rect];
    [picker setDatePickerMode:UIDatePickerModeTime];
    picker.minuteInterval = 5;
    [self.view addSubview:picker];
    */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actBtnClicked {
    self.pickerView = [[ETimePicker alloc] initOnView:self.view];
    //[self.pickerView actSetDatePickerMode:UIDatePickerModeDateAndTime];
    [self.pickerView actSetDate:[NSDate dateWithTimeIntervalSinceNow:10000]];
    self.pickerView.callbackSelected = ^(NSInteger minute, NSInteger hour, NSInteger day, NSInteger month, NSInteger year) {
        //
        NSString *str_info = [NSString stringWithFormat:@"%zd-%02zd-%02zd %02zd:%02zd", year, month, day, hour, minute];
        self.lb.text = str_info;
    };
    
    self.pickerView.callbackOK = ^(NSInteger minute, NSInteger hour, NSInteger day, NSInteger month, NSInteger year) {
        //
        NSString *str_info = [NSString stringWithFormat:@"%zd-%02zd-%02zd %02zd:%02zd", year, month, day, hour, minute];
        self.lb.text = str_info;
    };
}


@end
