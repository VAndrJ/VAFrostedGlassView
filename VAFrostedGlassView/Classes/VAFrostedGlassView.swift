//
//  VAFrostedGlassView.swift
//  VAFrostedGlassView
//
//  Created by Volodymyr Andriienko on 13.04.2024.
//

import UIKit

open class VAFrostedGlassView: VANeonVisualEffectView {
    public struct Context {
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
    }

    public init(context: Context) {
        super.init(
            effect: UIBlurEffect(style: .systemUltraThinMaterial),
            context: .init(
                corner: context.corner,
                border: context.border,
                shadow: context.shadow,
                neon: context.neon,
                pointer: context.pointer,
                excludedFilters: [.colorBrightness, .colorSaturate, .luminanceCurveMap],
                thickness: context.thickness
            )
        )
    }
}
