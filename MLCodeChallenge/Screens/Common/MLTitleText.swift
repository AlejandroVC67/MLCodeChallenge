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
        static let backgroundColor: Color = .background
        static let textColor: Color = .mainContent
    }
    
    var body: some View {
        Text(text)
            .bold()
            .foregroundColor(Constants.textColor)
            .font(.title)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

struct MLTitleText_Previews: PreviewProvider {
    static var previews: some View {
        MLTitleText(text: "Test")
    }
}
