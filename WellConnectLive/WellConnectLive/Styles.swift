//
//  Styles.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 15/8/23.
//

import Foundation
import SwiftUI


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


extension TextField {
    func textFieldStyle() -> some View {
        self
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}
