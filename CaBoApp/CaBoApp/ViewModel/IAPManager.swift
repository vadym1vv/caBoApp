//
//  IAPManager.swift
//  CaBoApp
//
//  Created by Vadym Vasylaki on 18.12.2025.
//

import Foundation

import StoreKit
class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let shared = IAPManager()
    
    private var products = [SKProduct]()
    fileprivate var productRequest: SKProductsRequest?

    override init() {
            super.init()
            SKPaymentQueue.default().add(self)
        }
    
    func fetchProducts() {
        let identifiers: Set<String> = ["com.caboapp.export", "com.caboapp.reset"]
        productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest?.delegate = self
        productRequest?.start()
        SKPaymentQueue.default().add(self)
    }

    func purchase(productID: String) {
        guard let product = products.first(where: { $0.productIdentifier == productID }) else { return }
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased, .restored:
               
                UserDefaults.standard.set(true, forKey: transaction.payment.productIdentifier)
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
            default: break
            }
        }
    }
}
