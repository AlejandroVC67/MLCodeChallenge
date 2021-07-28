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
    
    @ObservedObject private var presenter: ProductDetailPresenter
    
    init(presenter: ProductDetailPresenter) {
        self.presenter = presenter
        self.presenter.downloadProductDetail()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    ProductDetailGallery(images: presenter.productImages)
                        .frame(height: Constants.ProductDetailGallery.height)
                    MLTitleText(text: presenter.getProductName())
                        .lineLimit(Int.max)
                }
                ProductDetailItemView(text: presenter.getProductCondition())
                ProductDetailItemView(text: presenter.getProductQuantity())
                ProductDetailItemView(text: presenter.getProductPrice())
                MLTitleText(text: Constants.caracteristicas)
                ForEach(presenter.getProductAttributes(), id: \.self) { attribute in
                    VStack {
                        Text(attribute.name)
                        Text(attribute.valueName ?? "")
                    }
                }
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
