//
//  DropDown1ViewController.m
//  b866
//
//  Created by yufu on 13-11-20.
//  Copyright (c) 2013年 ccnyou. All rights reserved.
//

#import "DropDownView.h"

@implementation DropDownView

@synthesize tv, tableArray, textField;

- (void)dealloc
{
    [tv release];
    [tableArray release];
    [textField release];
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame
{
    if (frame.size.height < 200) {
        frameHeight = 200;
    } else {
        frameHeight = frame.size.height;
    }
    
    tabheight = frameHeight - 30;
    //frame.size.height = 30.0f;

    self = [super initWithFrame:frame];
    if(self) {
        showList = NO; //默认不显示下拉框

        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 0)];
        tv.delegate = self;
        tv.dataSource = self;
        tv.backgroundColor = [UIColor grayColor];
        tv.separatorColor = [UIColor lightGrayColor];
        tv.hidden = YES;
        [self addSubview:tv];
        
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        textField.borderStyle=UITextBorderStyleRoundedRect;//设置文本框的边框风格
        textField.delegate = self;
        [textField addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:textField];
    }
    
    return self;
}

- (void)hide
{
    [textField resignFirstResponder];
    showList = NO;
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownViewDidHide:)]) {
        [_delegate dropDownViewDidHide:self];
    }
}


-(void)dropdown{
    [textField resignFirstResponder];
    
    if (showList) {//如果下拉框已显示，什么都不做
        
        return;
    } else {//如果下拉框尚未显示，则进行显示
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        
        tv.hidden = NO;
        showList = YES;//显示下拉框
        
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
        frame.size.height = tabheight;
        
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        self.frame = sf;
        tv.frame = frame;
        
        [UIView commitAnimations];
        
        if (_delegate && [_delegate respondsToSelector:@selector(dropDownViewDidDropDown:)]) {
            [_delegate dropDownViewDidDropDown:self];
        }
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DropDownTableViewCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    textField.text = [tableArray objectAtIndex:[indexPath row]];
    [self hide];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation

{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self hide];
}

@end


