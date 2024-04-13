//
//  ContentView.swift
//  VAFrostedGlassView_Example
//
//  Created by Volodymyr Andriienko on 13.04.2024.
//

import SwiftUI
import VAFrostedGlassView

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                VAFrostedGlassSUIView(corner: .init(radius: 8))
                    .aspectRatio(1, contentMode: .fit)
                VAFrostedGlassSUIView(
                    corner: .init(radius: 8),
                    border: .init(color: .systemYellow.withAlphaComponent(0.4), width: 1),
                    neon: .init(color: .systemYellow, width: 10),
                    thickness: 1
                )
                .aspectRatio(1, contentMode: .fit)
            }
            VAFrostedGlassSUIView(
                corner: .init(radius: 48),
                border: .init(color: .green.withAlphaComponent(0.3), width: 2),
                neon: .init(color: .green, width: 10),
                pointer: .init(radius: 40, color: .green),
                thickness: 1
            )
            .aspectRatio(1, contentMode: .fit)
            Spacer()
        }
        .padding(.all, 16)
        .background(
            Image("example")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
