//
//  ETimePicker.h
//  ETimePicker
//
//  Created by measta on 2017/4/3.
//  Copyright © 2017年 meast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETimePicker : UIView

@property (nonatomic, copy) void(^callbackOK)(NSInteger minute, NSInteger hour, NSInteger day, NSInteger month, NSInteger year);
@property (nonatomic, copy) void(^callbackSelected)(NSInteger minute, NSInteger hour, NSInteger day, NSInteger month, NSInteger year);

- (instancetype)initOnView:(UIView *)view;
-(void)actSetDatePickerMode:(UIDatePickerMode)mode;
-(void)actSetDate:(NSDate *)date;

@end
