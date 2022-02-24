//
//  ProductDetailGallery.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import SwiftUI

struct ProductDetailGallery: View {

    var images: [UIImage] = []
    
    init(images: [UIImage]) {
        let images = images.isEmpty
        ? [.init(named: "categoryPlaceholder")!]
        : images
        self.images = images
    }
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) {
                Image(uiImage: $0)
                    .resizable()
                    .scaledToFit()
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }

}

struct ProductDetailGallery_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailGallery.init(images: [
            .init(systemName: "circle")!,
            .init(systemName: "pencil")!
        ])
    }
}
