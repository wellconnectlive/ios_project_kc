//
//  Styles.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 15/8/23.
//

import Foundation
import SwiftUI

/*
extension Button where Label == Text {
    func buttonStyle() -> some View {
        self
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
*/
extension Button where Label == Text {
    func buttonStyle() -> some View {
        self
            .padding()
            .background(Color.primaryButtonColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}


extension TextField {
    func textFieldStyle() -> some View {
        self
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}


extension Color {
    // Nota que el alpha es 0, así que este color será transparente.
    static let primaryButtonColor = Color(red: 0 / 255, green: 173 / 255, blue: 217 / 255)
    static let secondaryButtonColor = Color(red: 0 / 255, green: 89 / 255, blue: 109 / 255)
    static let tertiaryButtonColor = Color(red: 139 / 255, green: 172 / 255, blue: 191 / 255, opacity: 0)
}



