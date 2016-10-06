//
//  datePickerView.h
//  datePickView
//
//  Created by macbook pro on 16/10/6.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol datePickerViewDelegate <NSObject>
- (void)dateConfirmFormStr:(NSString *)dateStr;
@end
@interface datePickerView : UIView
@property (nonatomic,assign) id<datePickerViewDelegate> delegate;
@property (nonatomic)NSInteger numberOfComponents;
- (instancetype)initWithNumberOfComponents:(NSInteger)numberOfComponents;
- (void)show;
@end
