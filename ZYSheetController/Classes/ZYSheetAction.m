//
//  ZYSheetAction.m
//  SignalWallet
//
//  Created by Zhao Yan on 2019/7/25.
//  Copyright © 2019 lotus. All rights reserved.
//

#import "ZYSheetAction.h"
#import <Masonry/Masonry.h>
@interface ZYSheetAction ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation ZYSheetAction
{
    UIFont *font;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        font = [UIFont systemFontOfSize: 14];
        _textColor = [UIColor blackColor];
        _actionStyle = ZYSheetActionStyleDefault;
        _label = [UILabel new];
        _label.font = font;
        _label.textColor = _textColor;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

-(instancetype)init
{
    return [self initWithFrame: CGRectZero];
}

+(instancetype)new
{
    @throw @"请使用+actionWithTitle方法初始化实例对象";
}

+(instancetype)actionWithTitle:(NSString *)title textColor:(UIColor *)textColor actionStyle:(ZYSheetActionStyle)actionStyle completionHandler:(completionHandler)handler
{
    ZYSheetAction *action = [[ZYSheetAction alloc] init];
    action.title = title;
    if (textColor) {
        action.textColor = textColor;
    }
    action.label.text = title;
    action.actionStyle = actionStyle;
    action.handler = handler;
    return action;
}

+(instancetype)actionWithTitle:(NSString *)title actionStyle:(ZYSheetActionStyle)actionStyle completionHandler:(completionHandler)handler{
    
    return [self actionWithTitle: title textColor: nil actionStyle: actionStyle completionHandler: handler];
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _label.textColor = textColor;
}

@end
