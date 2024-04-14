//
//  VAFrostedGlassSUIView.swift
//  VAFrostedGlassView
//
//  Created by Volodymyr Andriienko on 14.04.2024.
//

#if canImport(SwiftUI)
import SwiftUI

public struct VAFrostedGlassSUIView: UIViewRepresentable {
    let corner: VANeonVisualEffectView.Corner
    let border: VANeonVisualEffectView.Border
    let shadow: VANeonVisualEffectView.Shadow
    let neon: VANeonVisualEffectView.Neon?
    let pointer: VANeonVisualEffectView.Pointer?
    let thickness: CGFloat

    public init(
        corner: VANeonVisualEffectView.Corner,
        border: VANeonVisualEffectView.Border = .init(
            color: .systemGray2,
            width: 1
        ),
        shadow: VANeonVisualEffectView.Shadow = .init(
            radius: 8,
            opacity: 0.6,
            offset: .init(width: 1, height: 1)
        ),
        neon: VANeonVisualEffectView.Neon? = nil,
        pointer: VANeonVisualEffectView.Pointer? = nil,
        thickness: CGFloat = 0.5
    ) {
        self.corner = corner
        self.border = border
        self.shadow = shadow
        self.neon = neon
        self.pointer = pointer
        self.thickness = thickness
    }

    public func makeUIView(context: Context) -> VAFrostedGlassView {
        .init(context: .init(
            corner: corner,
            border: border,
            shadow: shadow,
            neon: neon,
            pointer: pointer,
            thickness: thickness
        ))
    }

    public func updateUIView(_ uiView: VAFrostedGlassView, context: Context) {}
}
#endif
