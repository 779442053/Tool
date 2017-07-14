//
//  YGIAPTool.m
//  AllYoga
//
//  Created by liwei on 2017/7/7.
//  Copyright © 2017年 biyunkeji. All rights reserved.
//

#import "YGIAPTool.h"

@interface YGIAPTool ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>
//记录当前正在执行的订单任务
@property (nonatomic,strong) SKPaymentTransaction *currentTransaction;

@end

@implementation YGIAPTool

+ (instancetype)sharedInstance {

    static YGIAPTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YGIAPTool alloc] init];
    });
    return  tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self removeOldTransaction];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

- (void)removeOldTransaction {

    NSArray *tansactions = [SKPaymentQueue defaultQueue].transactions;
    //如果没有移除过订单信息
    BOOL result = NO;
    
    if ( ![[NSUserDefaults standardUserDefaults] boolForKey:@"hasFinishOldTransaction"] && tansactions.count > 0) {
        for (SKPaymentTransaction *transaction in tansactions) {
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
        result = YES;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasFinishOldTransaction"];
    if (result) {
        return;
    }

}


//判断是否允许内购项目
+ (BOOL)canMakePayments {

    return [SKPaymentQueue canMakePayments];
}
//根据商品id创建支付请求
- (void)startPaymentWithProductId:(NSString *)productId {
    if (productId == nil) {
        return;
    }
    NSArray *product=[[NSArray alloc] initWithObjects:productId,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    request.delegate=self;
    [request start];
}

//获取到商品信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {

    NSArray *myProduct = response.products; //返回许多商品
    SKProduct *vipProduct = nil;
    for(SKProduct *product in myProduct) {
        vipProduct = product;
    }
    
    //根据获取到的商品信息创建订单
    if (vipProduct) {
        SKPayment *payment = [SKPayment paymentWithProduct:vipProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
        //日志记录
//        NSString *content = [NSString stringWithFormat:@"创建订单操作;内购商品identifier=%@",vipProduct.productIdentifier];
//        [[YGNetWorkTool sharedInstance] ApplePayDebugCreate:content success:^(id responseObj) {
//            YGLog(@"创建订单操作成功");
//        } failure:^(NSError *error) {
//            YGLog(@"创建订单操作失败");
//        }];
    }
}
//商品信息请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    if (self.transactionFailure) {
        self.transactionFailure(self.currentTransaction);
    }
    self.ID = nil;
}
//商品信息请求完成
- (void)requestDidFinish:(SKRequest *)request {
    
}

#pragma mark - 监听订单支付的状态
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        
        //否则，执行
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased://订单支付完成
                [self requestValidReceipt:transaction];
                break;
           case SKPaymentTransactionStateFailed://订单支付失败
                
                [self failureTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过
                self.currentTransaction = transaction;
                [self removeTransaction];
                break;
            case SKPaymentTransactionStatePurchasing://商品正在采购
                break;
            default:
                break;
        }
    }
}

- (void)failureTransaction:(SKPaymentTransaction *)transaction {
    
    if (self.currentTransaction == transaction) {
        return;
    }
    self.currentTransaction = transaction;
    if (self.transactionFailure) {
        self.transactionFailure(self.currentTransaction);
    }
    self.ID = nil;
    [self removeTransaction];
    [self buyFailure];
}

- (void)removeTransaction {

    [[SKPaymentQueue defaultQueue] finishTransaction:self.currentTransaction];
}



-(void)dealloc {

    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)requestValidReceipt:(SKPaymentTransaction *)transaction {
    
    self.currentTransaction = transaction;

    //交易验证
    NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:recepitURL];
    
    if(!receiptData){
        [kWindow showLoadingView:@"获取支付凭证为空"];
        return;
    }
    //转化为base64字符串
    NSString *receiptString= [receiptData base64EncodedStringWithOptions:0];
    
    //检查本地是否存储了当前凭证，如果有，什么也不做，这个是为了避免重复验证交易和充值
//    if ([YGDataBase isReceiptExists:receiptString]) {
//        return;
//    }

    //日志记录
    [self buySuccess];

    //1.先将凭证存起来
//    [YGDataBase saveReceiptAndGoodsID:receiptString goodId:self.ID];
    //移除订单
    [self removeTransaction];
//日志记录
    [self startValidReceipt:receiptString];
    
    //2.传给服务端凭证数据
//    [kWindow showLoadingView];
//    [[YGNetWorkTool sharedInstance] ApplePayReceiptVerifyBuyId:self.ID buyType:1 receipt:receiptString success:^(id responseObj) {
//        [kWindow hideLoadingView];
//        if ([responseObj[@"code"] intValue] != 200 ) {
//            [kWindow showLoadingView:responseObj[@"msg"]];
//        }else {//充值成功之后将凭证移除，这个一定要放到200中，如果服务端由于某些原因验证失败或者返回的不是200，本地凭证还得留着在合适的时机再次验证，知道充值成功，再移除
//            
//            [YGDataBase removeReceipt:receiptString];
//        }
//        if (self.transactionSuccess) {
//            self.transactionSuccess(self.currentTransaction);
//        }
//        [self showAlert];
//        self.ID = nil;
//        
//    } failure:^(NSError *error) {
//        [kWindow hideLoadingView];
//        if (self.transactionSuccess) {
//            self.transactionSuccess(self.currentTransaction);
//        }
//        self.ID = nil;
//    }];

}

/*
- (void)buySuccess {
    NSString *content = [NSString stringWithFormat:@"支付成功;"];
    [[YGNetWorkTool sharedInstance] ApplePayDebugCreate:content success:^(id responseObj) {
        YGLog(@"支付成功记录成功");
    } failure:^(NSError *error) {
        YGLog(@"支付成功记录失败");
    }];
}

- (void)buyFailure {
    NSString *content = [NSString stringWithFormat:@"支付失败;"];
    [[YGNetWorkTool sharedInstance] ApplePayDebugCreate:content success:^(id responseObj) {
        YGLog(@"支付失败操作成功");
    } failure:^(NSError *error) {
        YGLog(@"支付失败");
    }];

}

- (void)startValidReceipt:(NSString *)receiptString {
    NSString *content = [NSString stringWithFormat:@"准备发送凭证验证;商品ID=%@;凭证=%@",self.transactionId,receiptString];
    [[YGNetWorkTool sharedInstance] ApplePayDebugCreate:content success:^(id responseObj) {
        YGLog(@"开始发送凭证验证记录成功");
    } failure:^(NSError *error) {
        YGLog(@"开始发送凭证验证记录失败");
    }];

}

- (void)showAlert {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"购买成功" message:@"会员期到账时间有一定的延迟，请稍后到会员期主页查看" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
 */

@end


