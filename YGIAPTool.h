//
//  YGIAPTool.h
//  AllYoga
//
//  Created by liwei on 2017/7/7.
//  Copyright © 2017年 biyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface YGIAPTool : NSObject

//订单支付成功
@property (nonatomic,copy) void (^transactionSuccess)(SKPaymentTransaction *transaction);

//订单支付失败
@property (nonatomic,copy) void (^transactionFailure)(SKPaymentTransaction *transaction);

@property (nonatomic,copy) NSString *ID;//这是服务端数据库对应的商品id
//初始化
+ (instancetype)sharedInstance;
//验证是否开启内购
+ (BOOL)canMakePayments;

//根据商品id创建支付请求
- (void)startPaymentWithProductId:(NSString *)productId;
//移除当前交易
- (void)removeTransaction;

@end
