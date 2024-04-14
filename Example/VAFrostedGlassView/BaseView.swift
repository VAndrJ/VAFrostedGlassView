//
//  BaseView.swift
//  VAFrostedGlassView_Example
//
//  Created by Volodymyr Andriienko on 10.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

class BaseView: UIView {

    init() {
        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128))

        addElements()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addElements() {}

    func bind() {}
}

class AdjustmentGestureRecognizer: UIPanGestureRecognizer, UIGestureRecognizerDelegate {
    private let onChangeX: (_ percent: CGFloat) -> Void
    private let onChangeY: (_ percent: CGFloat) -> Void

    init(
        onChangeX: @escaping (_ percent: CGFloat) -> Void,
        onChangeY: @escaping (_ percent: CGFloat) -> Void
    ) {
        self.onChangeX = onChangeX
        self.onChangeY = onChangeY

        super.init(target: nil, action: nil)

        delegate = self
        addTarget(self, action: #selector(onPan(_:)))
    }

    @objc private func onPan(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else { return }

        switch sender.state {
        case .changed:
            let translation = sender.translation(in: view)
            onChangeX(translation.x / view.frame.width)
            onChangeY(translation.y / view.frame.height)
            sender.setTranslation(.zero, in: view)
        default:
            break
        }
    }

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        true
    }
}
