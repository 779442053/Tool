//
//  YGHorizontalView.h
//  AllYoga
//
//  Created by liwei on 2017/7/18.
//  Copyright © 2017年 biyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YGHorizontalLayoutDirectionLeft,//从左往右
    YGHorizontalLayoutDirectionRight,//从右往左
    YGHorizontalLayoutDirectionCenter//从中间向两边
} YGHorizontalLayoutDirection;

@interface YGHorizontalView : UIControl

/**  布局方向  */
@property (nonatomic,assign) YGHorizontalLayoutDirection layoutDirection;

/** 左侧文字 */
@property (nonatomic,copy) NSString *frontContent;
/**  左侧文字大小 */
@property (nonatomic,strong) UIFont *frontFont;
/**  左侧文字颜色 */
@property (nonatomic,strong) UIColor *frontColor;
/**  左侧文字对齐方式 */
@property (nonatomic) NSTextAlignment frontAlign;


/** 右侧文字  */
@property (nonatomic,copy) NSString *trailContent;
/**  右侧文字大小  */
@property (nonatomic,strong) UIFont *trailFont;
/**   右侧文字颜色 */
@property (nonatomic,strong) UIColor *trailColor;
/**   右侧文字对齐方式 */
@property (nonatomic) NSTextAlignment trailAlign;

/** 图片名称 */
@property (nonatomic,copy) NSString *imageName;

/** 图片填充模式 */
@property (nonatomic,assign) UIViewContentMode contentMode;

/** 图片的内边距 */
@property (nonatomic,assign) UIEdgeInsets imageViewInset;

/**  左右文字的内边距 **/
@property (nonatomic,assign) UIEdgeInsets textInset;

@end
