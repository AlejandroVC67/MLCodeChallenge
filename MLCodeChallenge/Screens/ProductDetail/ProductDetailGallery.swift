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
    
    var body: some View {
        TabView {
            ForEach(images, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct ProductDetailGallery_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailGallery()
    }
}
