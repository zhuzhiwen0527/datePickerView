//
//  datePickerView.m
//  datePickView
//
//  Created by macbook pro on 16/10/6.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "datePickerView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define pHeight 300
@interface datePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{

    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *monthMutableArray;
    NSMutableArray *DaysMutableArray;
    NSMutableArray *DaysArray;
    NSString *currentMonthString;
    
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    
    BOOL firstTimeLoad;
    
    NSInteger m ;
    int year;
    int month;
    int day;
}
@property (nonatomic,copy)UIView * backView;
@property (nonatomic,copy)UIPickerView * pickerView;


@end
@implementation datePickerView

- (instancetype)initWithNumberOfComponents:(NSInteger)numberOfComponents;
{
    self = [super initWithFrame:CGRectZero];
    if (self) {

        self.numberOfComponents = numberOfComponents;
        self.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.frame = [UIScreen mainScreen].bounds;
        [self createDataScource];
        [self createPickerView];
        // 设置初始默认值
        if (numberOfComponents == 3) {
            
            [_pickerView selectRow:yearArray.count-1 inComponent:0 animated:YES];
            [_pickerView selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
            [_pickerView selectRow:DaysMutableArray.count-1 inComponent:2 animated:YES];
          
            
        }else if (numberOfComponents == 2){
        
            [_pickerView selectRow:yearArray.count-1 inComponent:0 animated:YES];
            [_pickerView selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
        }else{
            
            [_pickerView selectRow:yearArray.count-1 inComponent:0 animated:YES];
        }
   
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

#pragma mark --dataSource
- (void)createDataScource{


    NSDate *date = [NSDate date];
    
    // Get Current Year
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    year =[currentyearString intValue];
    
    
    // Get Current  Month
    
    [formatter setDateFormat:@"MM"];
    
    currentMonthString = [NSString stringWithFormat:@"%ld",(long)[[formatter stringFromDate:date]integerValue]];
    month=[currentMonthString intValue];
    // Get Current  Date
    
    [formatter setDateFormat:@"dd"];
    
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    day =[currentDateString intValue];
    
    
    yearArray = [[NSMutableArray alloc]init];
    monthMutableArray = [[NSMutableArray alloc]init];
    DaysMutableArray= [[NSMutableArray alloc]init];
    for (int i = 1970; i <= year ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    
    // PickerView -  Months data
    
    
    monthArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    for (int i=1; i<month+1; i++) {
        [monthMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    DaysArray = [[NSMutableArray alloc]init];
    
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    for (int i = 1; i <day+1; i++)
    {
        [DaysMutableArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }


}

#pragma mark --pickerView
- (void)createPickerView{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-pHeight, kScreenHeight, pHeight)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    UIButton *dateCancleButton=[[UIButton alloc] initWithFrame:CGRectMake(10,0,44,44)];
    [dateCancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [dateCancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [dateCancleButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [dateCancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backView addSubview:dateCancleButton];
    UIButton *dateConfirmButton=[[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-54,0,44,44)];
    [dateConfirmButton addTarget:self action:@selector(dateConfirmClick) forControlEvents:UIControlEventTouchUpInside];
    [dateConfirmButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [dateConfirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateConfirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_backView addSubview:dateConfirmButton];
   UILabel * _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(54,0, kScreenWidth-108,44)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"选择日期";
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:_titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44,kScreenWidth, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [_backView addSubview:lineView];
    
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, pHeight-45)];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [_pickerView setShowsSelectionIndicator:YES];
    [_backView addSubview:_pickerView];

}

- (void)dateConfirmClick{


        
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(dateConfirmFormStr:)] == YES) {
                
                NSString * yearStr = [yearArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
                NSString * monthStr = @"";
                if (self.numberOfComponents == 2 || self.numberOfComponents == 3) {
                    monthStr = [monthArray objectAtIndex:[self.pickerView selectedRowInComponent:1]];
                }
                NSString * dayStr = @"";
                if (self.numberOfComponents == 3) {
                    dayStr = [DaysArray objectAtIndex:[self.pickerView selectedRowInComponent:2]];
                }
              NSString * dateStr = [NSString stringWithFormat:@"%@/%@/%@ ",yearStr,monthStr,dayStr];
                [self.delegate dateConfirmFormStr:dateStr];
            }
        }
        
        [self removeAnimation];

}

#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    m=row;
    
    
   
    if (component == 0)
    {
        selectedYearRow = row;
        [self.pickerView reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.pickerView reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [self.pickerView reloadAllComponents];
        
    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
   
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:18.0f]];
    }
    
    
    
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }
    
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return self.numberOfComponents;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {
        NSInteger selectRow =  [pickerView selectedRowInComponent:0];
        int n;
        n= year-1970;
        if (selectRow==n) {
            return [monthMutableArray count];
        }else
        {
            return [monthArray count];
            
        }
    }
    else
    {
        NSInteger selectRow1 =  [pickerView selectedRowInComponent:0];
        int n;
        n= year-1970;
        NSInteger selectRow =  [pickerView selectedRowInComponent:1];
        
        if (selectRow==month-1 &selectRow1==n) {
            
            return day;
            
        }else{
            
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }
            else if (selectedMonthRow == 1)
            {
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }
                else
                {
                    return 28; // or return 29
                }
                
                
                
            }
            else
            {
                return 30;
            }
            
            
        }
        
    }
  
}


-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 90;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 70;
            break;
            
        default:
            return 90;
            break;
    }
}
#pragma mark --show
- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    [self addAnimation];
}

- (void)addAnimation {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.backView setFrame:CGRectMake(0, self.frame.size.height - self.backView.frame.size.height, kScreenWidth, self.pickerView.frame.size.height)];
        
    } completion:^(BOOL finished) {
    }];
}

- (void)removeAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        [self.backView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)hide {
    [self removeAnimation];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
