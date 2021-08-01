//
//  ProductDetailItemView.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import SwiftUI

struct ProductDetailItemView: View {
    private enum Constants {
        static let color: Color = .secundaryContent
    }
    
    var text: String
    
    var body: some View {
        VStack {
            HStack {
                Text(text)
                    .foregroundColor(Constants.color)
                    .padding(.leading)
                    .padding(.top, 20)
                    .lineLimit(Int.max)
                Spacer()
            }
            Divider()
        }
    }
}

struct ProductDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailItemView(text: "Test")
    }
}
