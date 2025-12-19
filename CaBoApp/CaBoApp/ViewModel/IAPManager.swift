import Foundation
import StoreKit

final class IAPManager: NSObject,
                        SKProductsRequestDelegate,
                        SKPaymentTransactionObserver, ObservableObject {
    
    static let shared = IAPManager()
    
    private var products: [SKProduct] = []
    private var productRequest: SKProductsRequest?
    
    @Published var restorationWasSuccessful: Bool = false
    
    private override init() {
        super.init()
    }
    
    func start() {
        SKPaymentQueue.default().add(self)
        fetchProducts()
    }
    
    func fetchProducts() {
        let identifiers: Set<String> = [
            "com.caboapp.export",
            "com.caboapp.reset"
        ]
        
        productRequest?.cancel()
        productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest?.delegate = self
        productRequest?.start()
    }
    
    func purchase(productID: String) {
        guard let product = products.first(where: {
            $0.productIdentifier == productID
        }) else {
            print("Product \(productID) not loaded from App Store")
            return
        }
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    func restorePurchases() {
        self.restorationWasSuccessful = false
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func productsRequest(_ request: SKProductsRequest,
                         didReceive response: SKProductsResponse) {
        products = response.products
        print("Loaded \(products.count) products")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased, .restored:
                UserDefaults.standard.set(
                    true,
                    forKey: transaction.payment.productIdentifier
                )
                if transaction.transactionState == .restored {
                    DispatchQueue.main.async {
                        self.restorationWasSuccessful = true
                    }
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Transaction successful for: \(transaction.payment.productIdentifier)")
                
            case .failed:
                if let error = transaction.error {
                    print("Transaction failed: \(error.localizedDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            default:
                break
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("All previous transactions have been restored successfully.")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("Restoration failed with error: \(error.localizedDescription)")
    }
}
