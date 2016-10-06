//
//  ViewController.m
//  datePickView
//
//  Created by macbook pro on 16/10/6.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ViewController.h"
#import "datePickerView.h"
@interface ViewController ()<datePickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *clickBtn;
@property (strong, nonatomic) IBOutlet UIButton *mothBtn;
@property (strong, nonatomic) IBOutlet UIButton *daybtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.view.backgroundColor = [UIColor blueColor];

}
- (IBAction)dayclick:(id)sender {
    datePickerView * v  =[[datePickerView alloc] initWithNumberOfComponents:1];
    v.delegate = self;
    [v show];
}
- (IBAction)mothclick:(id)sender {
    datePickerView * v  =[[datePickerView alloc] initWithNumberOfComponents:2];
    v.delegate = self;
    [v show];
}

- (IBAction)click:(id)sender {
    
    datePickerView * v  =[[datePickerView alloc] initWithNumberOfComponents:3];
    v.delegate = self;
    [v show];
}
- (void)dateConfirmFormStr:(NSString *)dateStr{

    NSLog(@"%@",dateStr);
//    [self.clickBtn setTitle:dateStr forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
