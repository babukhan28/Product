//
//  ProductViewModel.swift
//  Product
//
//  Created by Rajni on 12/05/23.
//

import Foundation

final class ProductViewModel {
    
    var products: [ProductModel] = []
    var eventHandler: ((_ event: Event) -> ())? //Data Binding by Closure
    
    func fetchProducts() {
        eventHandler?(.loading)
        APIManager.shared.request(modelType: [ProductModel].self, type: EndPointItems.products) { response in
            switch response {
            case .success(let getProducts):
                self.products = getProducts
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func addProduct(param: AddProductModel) {
        APIManager.shared.request(modelType: AddProductModel.self, type: EndPointItems.addProduct(addProduct: param)) { response in
            switch response {
            case .success(let product):
                self.eventHandler?(.newProductAdded(productAdded: product))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case newProductAdded(productAdded: AddProductModel)
    }
}
