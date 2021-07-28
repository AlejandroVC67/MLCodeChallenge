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
        static let backgroundColor: Color = .background
        
        enum ProductDetailGallery {
            static let height: CGFloat = 250
        }
        
        static let attributesTitle = "productdetail.attributes.title".localized
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
                MLTitleText(text: Constants.attributesTitle)
                ForEach(presenter.getProductAttributes(), id: \.self) { attribute in
                    let valueName = attribute.valueName ?? ""
                    ProductDetailItemView(text: attribute.name + ": " + valueName)
                }
            }.accentColor(.background)
        }
    }
}

struct ProductDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        let presenter = ProductDetailPresenter(productId: "MLA775138148", serviceProvider: ProductServiceFacade.self)
        ProductDetailView(presenter: presenter)
    }
}
