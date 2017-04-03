//
//  ETimePicker.m
//  ETimePicker
//
//  Created by measta on 2017/4/3.
//  Copyright © 2017年 meast. All rights reserved.
//

#import "ETimePicker.h"

@interface ETimePicker()

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *actionView;


@property (nonatomic, strong) UIButton *btnOK;
@property (nonatomic, strong) UIButton *btnCancel;

@end

@implementation ETimePicker

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initOnView:(UIView *)view {
    self = [super init];
    
    CGFloat width = view.bounds.size.width;
    CGFloat height = view.bounds.size.height;
    
    CGRect rect = view.bounds;
    
    self.maskView = [[UIView alloc] initWithFrame:rect];
    self.maskView.alpha = 0.4;
    [self.maskView setBackgroundColor:[UIColor blackColor]];
    
    CGRect rect_self = rect;
    rect_self.size.width = width * 0.6;
    rect_self.size.height = height * 0.5;
    rect_self.origin.x = width * 0.20;
    rect_self.origin.y = height * 0.25;
    
    [self setFrame:rect_self];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    CGRect rect_back = rect_self;
    rect_back.origin.x = 0;
    rect_back.origin.y = 0;
    
    CGRect rect_picker = rect_back;
    rect_picker.origin.x = 0;
    rect_picker.origin.y = 0;
    rect_picker.size.height -= 50;
    self.datePicker = [[UIDatePicker alloc] initWithFrame:rect_picker];
    [self.datePicker setUserInteractionEnabled:YES];
    
    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
    [self.datePicker setEnabled:YES];
    [self.datePicker addTarget:self action:@selector(actTimeChanged:) forControlEvents:UIControlEventValueChanged];
    
    CGRect rect_actview = rect_picker;
    rect_actview.origin.x = 0;
    rect_actview.origin.y = rect_picker.size.height + rect_picker.origin.y;
    rect_actview.size.height = 50;
    self.actionView = [[UIView alloc] initWithFrame:rect_actview];
    [self.actionView setBackgroundColor:[UIColor grayColor]];
    
    CGRect rect_btn_cancel = rect_actview;
    rect_btn_cancel.size.width = rect_actview.size.width * 0.5;
    rect_btn_cancel.origin.x = 0;
    rect_btn_cancel.origin.y = 0;
    CGRect rect_btn_ok = rect_btn_cancel;
    rect_btn_ok.origin.x = rect_actview.size.width * 0.5;
    
    self.btnOK = [[UIButton alloc] initWithFrame:rect_btn_ok];
    self.btnOK.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnOK setTitle:@"OK" forState:UIControlStateNormal];
    [self.btnOK setBackgroundColor:[UIColor whiteColor]];
    [self.btnOK setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    self.btnCancel = [[UIButton alloc] initWithFrame:rect_btn_cancel];
    self.btnCancel.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.btnCancel setBackgroundColor:[UIColor whiteColor]];
    [self.btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [self.btnOK addTarget:self action:@selector(actOK:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCancel addTarget:self action:@selector(actHide) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.actionView];
    [self addSubview:self.datePicker];
    [self.actionView addSubview:self.btnOK];
    [self.actionView addSubview:self.btnCancel];
    [view addSubview:self.maskView];
    [view addSubview:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actHide)];
    [self.maskView addGestureRecognizer:tap];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.maskView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.actionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.btnOK setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.btnCancel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.datePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // maskView
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.maskView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.maskView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.maskView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self.maskView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    // self
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:0.6 constant:0]];
    
    // datePicker
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.datePicker attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.datePicker attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.datePicker attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.datePicker attribute:NSLayoutAttributeBottom multiplier:1 constant:50]];
    
    // actionView
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.actionView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.actionView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.actionView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:50]];
    
    // btnOK
    [self.actionView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.btnOK attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    [self.actionView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.btnOK attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.actionView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnOK attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.actionView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnOK attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.actionView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0]];
    
    // btnCancel
    [self.actionView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.btnCancel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.actionView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.btnCancel attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.actionView addConstraint:[NSLayoutConstraint constraintWithItem:self.actionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.btnCancel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.actionView addConstraint:[NSLayoutConstraint constraintWithItem:self.btnCancel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.actionView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0]];
    
    return self;
}

-(void)actSetDatePickerMode:(UIDatePickerMode)mode {
    [self.datePicker setDatePickerMode:mode];
}

-(void)actHide {
    [self.maskView removeFromSuperview];
    [self removeFromSuperview];
}

-(void)actSetDate:(NSDate *)date {
    if(date) {
        [self.datePicker setDate:date];
    }
}

-(void)actTimeChanged:(UIButton *)sender {
    NSDate *date = [self.datePicker date];
    NSDateFormatter *date_formater = [[NSDateFormatter alloc] init];
    date_formater.dateFormat = @"yy:MM:dd HH:mm:ss";
    date_formater.dateFormat = @"mm";
    NSInteger minute = [[date_formater stringFromDate:date] integerValue];
    date_formater.dateFormat = @"HH";
    NSInteger hour = [[date_formater stringFromDate:date] integerValue];
    date_formater.dateFormat = @"dd";
    NSInteger day = [[date_formater stringFromDate:date] integerValue];
    date_formater.dateFormat = @"MM";
    NSInteger month = [[date_formater stringFromDate:date] integerValue];
    date_formater.dateFormat = @"yyyy";
    NSInteger year = [[date_formater stringFromDate:date] integerValue];
    if(self.callbackSelected) {
        self.callbackSelected(minute, hour, day, month, year);
    }
}

-(void)actOK:(UIButton *)sender {
    NSDate *date = [self.datePicker date];
    NSDateFormatter *date_formater = [[NSDateFormatter alloc] init];
    date_formater.dateFormat = @"yy:MM:dd HH:mm:ss";
    date_formater.dateFormat = @"mm";
    NSInteger minute = [[date_formater stringFromDate:date] integerValue];
    date_formater.dateFormat = @"HH";
    NSInteger hour = [[date_formater stringFromDate:date] integerValue];
    date_formater.dateFormat = @"dd";
    NSInteger day = [[date_formater stringFromDate:date] integerValue];
    date_formater.dateFormat = @"MM";
    NSInteger month = [[date_formater stringFromDate:date] integerValue];
    date_formater.dateFormat = @"yyyy";
    NSInteger year = [[date_formater stringFromDate:date] integerValue];
    if(self.callbackOK) {
        self.callbackOK(minute, hour, day, month, year);
    }
    [self actHide];
}

@end
