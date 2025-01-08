//
//  ExampleView.swift
//  VAFrostedGlassView_Example
//
//  Created by Volodymyr Andriienko on 10.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit
import VAFrostedGlassView

class ExampleView: BaseView {
    private let backgroundImageView = UIImageView(image: .init(named: "example"))
    private let frostedGlassExampleView = VAFrostedGlassView(context: .init(corner: .init(radius: 8)))
    private let frostedNeonGlassExampleView = VAFrostedGlassView(context: .init(
        corner: .init(radius: 8),
        border: .init(color: .systemYellow.withAlphaComponent(0.4), width: 1),
        neon: .init(color: .systemYellow, width: 10),
        thickness: 1
    ))
    private let frostedInteractiveGlassExampleView = VAFrostedGlassView(context: .init(
        corner: .init(radius: 48),
        border: .init(color: .green.withAlphaComponent(0.3), width: 1),
        neon: .init(color: .green, width: 15),
        pointer: .init(radius: 40, color: .green),
        thickness: 1
    ))

    override func addElements() {
        addAutolayoutSubviews(
            backgroundImageView,
            frostedGlassExampleView,
            frostedNeonGlassExampleView,
            frostedInteractiveGlassExampleView
        )
        backgroundImageView
            .toSuperEdges()
        frostedGlassExampleView
            .toSuper(anchors: .top, .left, constant: 16, isSafe: true)
            .toSuper(.width, multiplier: 0.5, constant: -24)
            .aspectWidth()
        frostedNeonGlassExampleView
            .toSuper(.top, constant: 16, isSafe: true)
            .toSuper(.right, constant: -16, isSafe: true)
            .toSuper(.width, multiplier: 0.5, constant: -24)
            .aspectWidth()
        frostedInteractiveGlassExampleView
            .anchor(.top, opposedTo: frostedGlassExampleView, constant: 16)
            .toSuperAxis(.horizontal, constant: 16)
            .aspectWidth()
    }

    override func bind() {
        frostedInteractiveGlassExampleView.addGestureRecognizer(AdjustmentGestureRecognizer(
            onChangeX: { [weak frostedInteractiveGlassExampleView] in
                frostedInteractiveGlassExampleView?.neonWidth += $0 * 30
            },
            onChangeY: { [weak frostedInteractiveGlassExampleView] in
                frostedInteractiveGlassExampleView?.thickness += $0
            }
        ))
    }
}
