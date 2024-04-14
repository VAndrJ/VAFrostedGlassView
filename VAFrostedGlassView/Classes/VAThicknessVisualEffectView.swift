//
//  VAThicknessVisualEffectView.swift
//  VAFrostedGlassView
//
//  Created by Volodymyr Andriienko on 13.04.2024.
//

import UIKit

public enum UIVisualEffectViewExcludedFilter: String {
    case luminanceCurveMap
    case colorSaturate
    case colorBrightness
    case gaussianBlur
}

public class VAThicknessVisualEffectView: UIVisualEffectView {
    public var thickness: CGFloat {
        didSet { updateThickness() }
    }

    private var backdropLayer: CALayer? { layer.sublayers?.first }
    private let excludedFilters: [String]
    private let initialEffect: UIVisualEffect?
    private let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    private var filtersObservation: NSKeyValueObservation?

    public init(
        effect: UIVisualEffect?,
        excludedFilters: [UIVisualEffectViewExcludedFilter],
        thickness: CGFloat = 1
    ) {
        self.initialEffect = effect
        self.excludedFilters = excludedFilters.map(\.rawValue)
        self.thickness = thickness

        super.init(effect: nil)

        updateAnimator()
        updateThickness()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateAnimator() {
        animator.stopAnimation(true)
        animator.addAnimations { [weak self] in
            self?.effect = self?.initialEffect
        }
    }

    private func updateThickness() {
        animator.fractionComplete = thickness
    }

    private func bind() {
        guard !excludedFilters.isEmpty else { return }

        filtersObservation = backdropLayer?.observe(
            \.filters,
             options: [.initial, .new],
             changeHandler: { [excludedFilters] layer, _ in
                 layer.filters?.removeAll(where: {
                     excludedFilters.contains(String(describing: $0))
                 })
             }
        )
    }

    deinit {
        filtersObservation?.invalidate()
        filtersObservation = nil
    }
}
