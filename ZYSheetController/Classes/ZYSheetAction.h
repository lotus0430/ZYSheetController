//
//  ZYSheetAction.h
//  SignalWallet
//
//  Created by Zhao Yan on 2019/7/25.
//  Copyright © 2019 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

/*按钮类型，cancel型在下面*/
typedef NS_ENUM(NSInteger, ZYSheetActionStyle) {
    ZYSheetActionStyleDefault,
    ZYSheetActionStyleCancel
};

typedef void(^completionHandler)(void);

NS_ASSUME_NONNULL_BEGIN

@interface ZYSheetAction : UIControl

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) ZYSheetActionStyle actionStyle;
@property (nonatomic, copy) completionHandler handler;

+(instancetype)actionWithTitle: (NSString *)title
                   actionStyle: (ZYSheetActionStyle)actionStyle
             completionHandler: (completionHandler)handler;

@end

NS_ASSUME_NONNULL_END
