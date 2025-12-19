import Foundation
import StoreKit

final class IAPManager: NSObject,
                         SKProductsRequestDelegate,
                         SKPaymentTransactionObserver {

    static let shared = IAPManager()

    private var products: [SKProduct] = []
    private var productRequest: SKProductsRequest?

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

    func handlePromotionalPurchase(productID: String) {
            guard let product = products.first(where: { $0.productIdentifier == productID }) else {
                print("Product not found for promotion")
                return
            }

            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    
    func purchase(productID: String) {
        guard let product = products.first(where: {
            $0.productIdentifier == productID
        }) else { return }

        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func productsRequest(_ request: SKProductsRequest,
                         didReceive response: SKProductsResponse) {
        products = response.products
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
                SKPaymentQueue.default().finishTransaction(transaction)

            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)

            default:
                break
            }
        }
    }
}
