//
//  VANeonVisualEffectView.swift
//  VAFrostedGlassView
//
//  Created by Volodymyr Andriienko on 13.04.2024.
//

import UIKit

open class VANeonVisualEffectView: UIView {
    public struct Corner {
        public let radius: CGFloat
        public let curve: CALayerCornerCurve

        public init(
            radius: CGFloat,
            curve: CALayerCornerCurve = .continuous
        ) {
            self.radius = radius
            self.curve = curve
        }
    }

    public struct Border {
        public let color: UIColor
        /// Defaults to `1 / traitCollection.displayScale`.
        public let width: CGFloat?

        public init(
            color: UIColor,
            width: CGFloat? = nil
        ) {
            self.color = color
            self.width = width
        }
    }

    public struct Neon {
        public let color: UIColor
        public let width: CGFloat

        public init(
            color: UIColor,
            width: CGFloat
        ) {
            self.color = color
            self.width = width
        }
    }

    public struct Shadow {
        public let radius: CGFloat
        public let color: UIColor
        public let opacity: Float
        public let offset: CGSize

        public init(
            radius: CGFloat = 16,
            color: UIColor = .black,
            opacity: Float = 0.2,
            offset: CGSize = .zero
        ) {
            self.radius = radius
            self.color = color
            self.opacity = opacity
            self.offset = offset
        }
    }

    public struct Pointer {
        public let radius: CGFloat
        public let color: UIColor
        public let isInstant: Bool

        public init(
            radius: CGFloat,
            color: UIColor,
            isInstant: Bool = true
        ) {
            self.radius = radius
            self.color = color
            self.isInstant = isInstant
        }
    }

    public struct Context {
        let corner: Corner
        let border: Border
        var shadow: Shadow
        var neon: Neon?
        var pointer: Pointer?
        var excludedFilters: [UIVisualEffectViewExcludedFilter]
        var thickness: CGFloat

        public init(
            corner: Corner,
            border: Border,
            shadow: Shadow = .init(),
            neon: Neon? = nil,
            pointer: Pointer? = nil,
            excludedFilters: [UIVisualEffectViewExcludedFilter] = [],
            thickness: CGFloat = 1
        ) {
            self.corner = corner
            self.border = border
            self.shadow = shadow
            self.neon = neon
            self.pointer = pointer
            self.excludedFilters = excludedFilters
            self.thickness = thickness
        }
    }

    public var thickness: CGFloat {
        get { visualEffectView.thickness }
        set {
            visualEffectView.thickness = max(0, min(1, newValue))
            updateColors()
        }
    }
    public var neonWidth: CGFloat {
        get { neon?.width ?? 0 }
        set {
            neon = .init(
                color: neon?.color ?? .clear,
                width: max(0, newValue)
            )
        }
    }
    public var shadow: Shadow {
        didSet {
            updateShadow()
            guard shadow.color != oldValue.color else { return }

            updateColors()
        }
    }
    public var neon: Neon? {
        didSet {
            updateNeon()
            guard neon?.color != oldValue?.color else { return }

            updateColors()
        }
    }
    public var border: Border {
        didSet {
            updateBorder()
            guard border.color != oldValue.color else { return }

            updateColors()
        }
    }
    public var corner: Corner {
        didSet { updateCorner() }
    }
    public var pointer: Pointer?
    public let visualEffectView: VAThicknessVisualEffectView
    public let neonView = UIView()

    private var pointerView: UIView? {
        didSet { oldValue?.removeFromSuperview() }
    }

    public init(effect: UIVisualEffect?, context: Context) {
        self.corner = context.corner
        self.border = context.border
        self.neon = context.neon
        self.pointer = context.pointer
        self.shadow = context.shadow
        self.visualEffectView = .init(
            effect: effect,
            excludedFilters: context.excludedFilters,
            thickness: context.thickness
        )

        super.init(frame: .init(x: 0, y: 0, width: 240, height: 128))

        addElements()
        configure()
        bind()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 12.0, *) {
            guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }

            updateColors()
        }
    }

    private func updateColors() {
        layer.borderColor = border.color.cgColor
        neonView.layer.borderColor = neon?.color.withAlphaComponent(thickness).cgColor
        layer.shadowColor = shadow.color.cgColor
        pointerView?.backgroundColor = pointer?.color.withAlphaComponent(thickness)
    }

    private func updateCorner() {
        layer.cornerRadius = corner.radius
        neonView.layer.cornerRadius = corner.radius
        neonView.layer.masksToBounds = true
        visualEffectView.layer.cornerRadius = corner.radius
        visualEffectView.layer.masksToBounds = true
        if #available(iOS 13, *) {
            layer.cornerCurve = corner.curve
            neonView.layer.cornerCurve = corner.curve
            visualEffectView.layer.cornerCurve = corner.curve
        }
    }

    private func updateBorder() {
        layer.borderWidth = border.width ?? 1 / traitCollection.displayScale
    }

    private func updateNeon() {
        neonView.layer.borderWidth = neon?.width ?? 0
    }

    private func updateShadow() {
        layer.shadowRadius = shadow.radius
        layer.shadowOffset = shadow.offset
        layer.shadowOpacity = shadow.opacity
    }

    @objc private func onPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let radius = pointer?.radius ?? 22
            let diameter = radius * 2
            let pointerView = UIView(frame: .init(
                origin: sender.location(in: self) - radius,
                size: .init(width: diameter, height: diameter)
            ))
            pointerView.layer.cornerRadius = radius
            pointerView.backgroundColor = pointer?.color.withAlphaComponent(thickness)
            neonView.addSubview(pointerView)
            self.pointerView = pointerView
        case .changed:
            pointerView?.center = sender.location(in: self)
        case .cancelled, .failed, .ended:
            pointerView = nil
        default:
            break
        }
    }

    private func bind() {
        guard let pointer else { return }

        isUserInteractionEnabled = true
        if pointer.isInstant {
            addGestureRecognizer(InstantPanGestureRecognizer(
                target: self,
                action: #selector(onPan(_:))
            ))
        } else {
            addGestureRecognizer(UIPanGestureRecognizer(
                target: self,
                action: #selector(onPan(_:))
            ))
        }
    }

    private func configure() {
        updateBorder()
        updateCorner()
        updateShadow()
        updateNeon()
        updateColors()
    }

    private func addElements() {
        add(view: neonView, to: self)
        add(view: visualEffectView, to: self)
    }

    private func add(view: UIView, to container: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: container.topAnchor),
            view.leftAnchor.constraint(equalTo: container.leftAnchor),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            view.rightAnchor.constraint(equalTo: container.rightAnchor),
        ])
    }
}

class InstantPanGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)

        state = .began
    }
}

extension CGPoint {

    static func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        .init(x: lhs.x - rhs, y: lhs.y - rhs)
    }
}
