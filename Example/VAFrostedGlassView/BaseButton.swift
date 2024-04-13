//
//  BaseButton.swift
//  VAFrostedGlassView_Example
//
//  Created by Volodymyr Andriienko on 13.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    var onTap: (() -> Void)?

    convenience init(title: String) {
        self.init(type: .system)

        setTitle(title, for: .normal)
        bind()
    }

    private func bind() {
        addTarget(
            self,
            action: #selector(onTouchUp),
            for: .touchUpInside
        )
    }

    @objc private func onTouchUp() {
        onTap?()
    }
}
