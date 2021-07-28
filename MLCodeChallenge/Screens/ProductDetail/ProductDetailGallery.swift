//
//  ProductDetailGallery.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import SwiftUI

struct ProductDetailGallery: View {
    var images: [String] = []
    
    var body: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(0..<images.count) { num in
                    Text("")
                }
            }.tabViewStyle(PageTabViewStyle())
            .frame(width: proxy.size.width)
        }
    }
}

struct ProductDetailGallery_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailGallery()
    }
}
