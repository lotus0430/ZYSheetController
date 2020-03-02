//
//  ZYSheetView.m
//  SignalWallet
//
//  Created by Zhao Yan on 2019/7/25.
//  Copyright © 2019 lotus. All rights reserved.
//

#import "ZYSheetView.h"
//#import <Masonry.h>
@interface ZYSheetView ()

@property (nonatomic, strong) UIControl *backView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray *defaultBtns;//一般按钮数组
@property (nonatomic, strong) NSMutableArray *cancelBtns;//取消按钮数组
@end

static CGFloat const cellHeight = 44.0;
static CGFloat const lineSpacing = 10.0;
#define SepHeight 1.0;
@implementation ZYSheetView
{
    CGFloat _contentHeight;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        
        [self addSubviews];
        
    }
    return self;
}

-(instancetype)init
{
    return [self initWithFrame: CGRectZero];
}

+(instancetype)new
{
    @throw @"请使用init方式初始化实例对象";
}

+(instancetype)sheetWithTitle:(NSString *)title
{
    ZYSheetView *sheetView = [[ZYSheetView alloc] init];
    sheetView.title = title;
    return sheetView;
}

-(void)addSubviews
{
    UIControl *backView = [UIControl new];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0;
    [backView addTarget: self action: @selector(dismiss) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _backView = backView;
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor clearColor];
    [self addSubview: bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(SepHeight);
        make.bottom.equalTo(self).offset(0.0);
    }];
    _bottomView = bottomView;
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview: contentView];
    _contentView = contentView;
}

-(void)addAction:(ZYSheetAction *)action
{
    if (action.actionStyle == ZYSheetActionStyleDefault) {
        [self.defaultBtns addObject: action];
    }
    else
    {
        [self.cancelBtns addObject: action];
    }
    //重组btns
    [self setupSubviews];
}

-(void)actionHandler: (ZYSheetAction *)action
{
    [self dismiss];
    if (action.actionStyle == ZYSheetActionStyleDefault &&
        action.handler) {
        action.handler();
    }
}

-(void)setupSubviews
{
    [self.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    CGFloat contentHeight = 0;
    
    UIView *lastView;
    NSMutableArray *defaultBtns = [NSMutableArray new];
    for (NSInteger i = self.defaultBtns.count - 1; i >= 0; i --) {
        [defaultBtns addObject: self.defaultBtns[i]];//倒序排列
    }
    for (NSInteger i = 0; i < self.cancelBtns.count + defaultBtns.count; i ++) {
        ZYSheetAction *action;
        if (i < self.cancelBtns.count) {
            action = self.cancelBtns[i];
        }
        else if (i - self.cancelBtns.count < defaultBtns.count)
        {
            action = defaultBtns[i - self.cancelBtns.count];
        }
        [action addTarget: self action: @selector(actionHandler:) forControlEvents: UIControlEventTouchUpInside];
        [self.contentView addSubview: action];
        [action mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastView) {
                make.bottom.equalTo(self.contentView);
            }
            else
            {
                make.bottom.mas_equalTo(lastView.mas_top);
            }
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(cellHeight);
        }];
        contentHeight += cellHeight;
        UIView *sepView = [UIView new];
        sepView.backgroundColor = sepColor_gray;
        [self.contentView addSubview: sepView];
        [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(action.mas_top);
            make.left.right.equalTo(action);
            if (i == self.cancelBtns.count - 1) {
                make.height.mas_equalTo(lineSpacing);
            }
            else
            {
                make.height.mas_equalTo(SepHeight);
            }
        }];
        if (i == self.cancelBtns.count - 1) {
            contentHeight += lineSpacing;
        }
        else
        {
            contentHeight += SepHeight;
        }
        lastView = sepView;
    }
    
    if (self.title.length > 0) {
        UILabel *label = [UILabel new];
        label.font = PFSC_Regular(13);
        label.textColor = textColor_mediumGray;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.title;
        [self.contentView addSubview: label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.mas_equalTo(cellHeight);
        }];
        contentHeight += cellHeight;
    }
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.bottomView);
        make.height.mas_equalTo(contentHeight);
    }];
    _contentHeight = contentHeight;
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(contentHeight);
    }];
    [self setNeedsUpdateConstraints];
    [self updateFocusIfNeeded];
}

-(void)show
{
    UIWindow *window = [[UIWindow alloc] initWithFrame: ScreenBouds];
    window.windowLevel = UIWindowLevelAlert;
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    [vc.view addSubview: self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(vc.view);
        make.bottom.equalTo(vc.view).offset(IPHONE_X ? -34 : 0);
    }];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
    [window layoutIfNeeded];
    _window = window;
    
    [UIView animateWithDuration: 0.3 animations:^{
        
        self.backView.alpha = 0.3;
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
        }];
        [self layoutIfNeeded];
    }];
}

-(void)dismiss
{
    CGFloat contentHeight = _contentHeight;
    [UIView animateWithDuration: 0.3 animations:^{
        self.backView.alpha = 0;
        [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(contentHeight);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        self.window.hidden = YES;
        self.window.rootViewController = nil;
        self.window = nil;
    }];
}

#pragma mark -- lazy load
-(NSMutableArray *)defaultBtns
{
    if (!_defaultBtns) {
        _defaultBtns = [NSMutableArray new];
    }
    return _defaultBtns;
}

-(NSMutableArray *)cancelBtns
{
    if (!_cancelBtns) {
        _cancelBtns = [NSMutableArray new];
    }
    return _cancelBtns;
}

@end
