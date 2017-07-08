//
//  YGIAPTool.swift
//  SwiftAllYoga
//
//  Created by liwei on 2017/7/7.
//  Copyright © 2017年 liwei. All rights reserved.
//

import UIKit
import StoreKit

class YGIAPTool: NSObject {

    var currentTransaction:SKPaymentTransaction!
    
    var transactionSuccess:((SKPaymentTransaction) -> ())?
    
    var transactionFailure:((SKPaymentTransaction) -> ())?
    
    
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    //验证是否能够内购
    public class func canMakePayments() -> Bool {
    
        return SKPaymentQueue.canMakePayments()
    }
    
    //根据商品id创建订单请求
    public func startPaymentRequest(productId:String) {
    
        var productArr = [String]()
        productArr.append(productId)
        let productSet = NSSet(array: productArr)
        let request = SKProductsRequest(productIdentifiers: productSet as! Set<String>)
        request.delegate = self
        request.start()
    }
    
    
    public func removeTransaction() {
        SKPaymentQueue.default().finishTransaction(currentTransaction)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    

    
}

extension YGIAPTool:SKPaymentTransactionObserver,SKProductsRequestDelegate {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            currentTransaction = transaction
            switch transaction.transactionState {
            case .purchased:
                if let block = transactionSuccess {
                    block(currentTransaction)
                }
                break
            case .failed:
                if let block = transactionFailure {
                    block(currentTransaction)
                }
                break
            case .restored:
                break
            case .purchasing:
                break
            default:
                break
            }
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        var vipProduct:SKProduct!
        for product in products {
            vipProduct = product
        }
        if vipProduct != nil {
            let payment = SKPayment(product: vipProduct)
            SKPaymentQueue.default().add(payment)
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        if let block = transactionFailure {
            block(currentTransaction)
        }
    }
    
    func requestDidFinish(_ request: SKRequest) {
        
    }
    
    
}
