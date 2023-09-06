//
//  CardDesignView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 14/8/23.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.primaryButtonColor, lineWidth: 1)
        )
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding([.leading, .trailing], 10)
    }
}


/*
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

*/
