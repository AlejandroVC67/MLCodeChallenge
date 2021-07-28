//
//  ColorExtension.swift
//  MLCodeChallenge
//
//  Created by Alejandro Villa Cardenas
//  Copyright © 2021  . All rights reserved.
//

import SwiftUI

extension Color {
    static var main: Color = Color(.mainColor  ?? .yellow)
    static var background: Color = Color(.background  ?? .white)
    static var mainContent: Color = Color(.mainContent  ?? .darkText)
    static var secundaryContent: Color = Color(.secundaryContent  ?? .darkText)
    static var black: Color = Color(.black  ?? .darkText)
}
