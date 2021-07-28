//
//  MLTitleText.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import SwiftUI

struct MLTitleText: View {
    let text: String
    
    private enum Constants {
        static let backgroundColor = Color(.background ?? .darkText)
        static let color = Color(.mainContent ?? .darkText)
    }
    
    var body: some View {
        Text(text)
            .bold()
            .foregroundColor(Constants.color)
            .font(.title)
    }
}

struct MLTitleText_Previews: PreviewProvider {
    static var previews: some View {
        MLTitleText(text: "Test")
    }
}
