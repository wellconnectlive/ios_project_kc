//
//  ProgressView.swift
//  WellConnectLive
//
//  Created by Markel Juaristi on 5/9/23.
//

import SwiftUI

struct RegisterProgressView: View {
    
    //para colorear los ciruclos pasamos estas posiciones del enum
    enum Step: Int {
        case profileInfo = 1
        case healthInfo
        case circleOfTrust
    }

    var currentStep: Step

    var body: some View {
        GeometryReader { geometry in
            let circleDiameter = geometry.size.width * 0.11
            let lineWidth = (geometry.size.width - (3 * circleDiameter)) / 2

            HStack(spacing: 0) {
                Circle()
                    .fill(currentStep.rawValue >= Step.profileInfo.rawValue ? Color.secondaryButtonColor : Color.gray)
                    .frame(width: circleDiameter, height: circleDiameter)
                    .overlay(Text("1")).foregroundColor(Color.white)

                Rectangle()
                    .fill(currentStep.rawValue >= Step.healthInfo.rawValue ? Color.secondaryButtonColor : Color.gray)
                    .frame(width: lineWidth, height: 10)

                Circle()
                    .fill(currentStep.rawValue >= Step.healthInfo.rawValue ? Color.secondaryButtonColor : Color.gray)
                    .frame(width: circleDiameter, height: circleDiameter)
                    .overlay(Text("2")).foregroundColor(Color.white)

                Rectangle()
                    .fill(currentStep.rawValue >= Step.circleOfTrust.rawValue ? Color.secondaryButtonColor : Color.gray)
                    .frame(width: lineWidth, height: 10)

                Circle()
                    .fill(currentStep.rawValue >= Step.circleOfTrust.rawValue ? Color.secondaryButtonColor : Color.gray)
                    .frame(width: circleDiameter, height: circleDiameter)
                    .overlay(Text("3")).foregroundColor(Color.white)
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterProgressView(currentStep: .circleOfTrust)
            .frame(width: UIScreen.main.bounds.width - 32, height: 60) // Esta línea asegura que el ancho es el de la pantalla menos un poco de padding en cada lado.
            .padding()
    }
}
