//
//  ProductDetailView.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    private enum Constants {
        static let backgroundColor = Color(.background ?? .blue)
        
        enum ProductDetailGallery {
            static let height: CGFloat = 250
        }
        
        static let caracteristicas = "Caracteristicas"
    }
    
    var presenter: ProductDetailPresenter
    
    var body: some View {
        ScrollView {
            Constants.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                VStack {                    ProductDetailGallery(images: [])
                        .frame(height: Constants.ProductDetailGallery.height)
                    MLTitleText(text: presenter.product.title)
                }
                ProductDetailItemView(text: "Condition: \(presenter.product.condition)")
                ProductDetailItemView(text: "price: \(presenter.product.price)")
                ProductDetailItemView(text: "Quantity: \(String(describing: presenter.product.availableQuantity))")
                MLTitleText(text: Constants.caracteristicas)
                List {
                    Text("hola").foregroundColor(.blue)
                }
                Spacer()
            }
        }
    }
}

struct ProductDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = ProductDetailPresenter(productId: "", serviceProvider: ProductServiceFacade.self)
        ProductDetailView(presenter: presenter)
    }
}
