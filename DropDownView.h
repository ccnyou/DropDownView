//
//  DropDownView.h
//  b866
//
//  Created by yufu on 13-11-20.
//  Copyright (c) 2013年 ccnyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownView;

@protocol DropDownViewDelegate <NSObject>

@optional
- (void)dropDownViewDidDropDown:(DropDownView *)dropDownView;
- (void)dropDownViewDidHide:(DropDownView *)dropDownView;

@end

@interface DropDownView : UIView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    
    UITableView *tv;//下拉列表
    
    NSArray *tableArray;//下拉列表数据
    
    UITextField *textField;//文本输入框
    
    BOOL showList;//是否弹出下拉列表
    
    CGFloat tabheight;//table下拉列表的高度
    
    CGFloat frameHeight;//frame的高度
    
}


@property (nonatomic, retain) UITableView *tv;
@property (nonatomic, retain) NSArray *tableArray;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, assign) id<DropDownViewDelegate> delegate;

- (void)hide;

@end