//
//  BaseViewController.swift
//  VAFrostedGlassView_Example
//
//  Created by Volodymyr Andriienko on 10.04.2024.
//  Copyright © 2024 Volodymyr Andriienko. All rights reserved.
//

import UIKit

class BaseViewController<V: UIView>: UIViewController {
    let contentView: V

    convenience init() {
        self.init(view: V())
    }

    init(view: V) {
        self.contentView = view

        super.init(nibName: nil, bundle: nil)
    }


    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }
}
