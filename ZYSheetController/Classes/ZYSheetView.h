//
//  ZYSheetView.h
//  SignalWallet
//
//  Created by Zhao Yan on 2019/7/25.
//  Copyright © 2019 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYSheetAction.h"
/*可自定义button样式的sheetView*/
NS_ASSUME_NONNULL_BEGIN

@interface ZYSheetView : UIView


+(instancetype)sheetWithTitle: (NSString *)title;
-(void)addAction: (ZYSheetAction *)action;
-(void)show;
-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
