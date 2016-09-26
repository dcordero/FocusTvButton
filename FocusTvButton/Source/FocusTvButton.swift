//
//  FocusTvButton.swift
//  FocusTvButton
//
//  Created by David Cordero on 01/09/16.
//  Copyright © 2016 David Cordero, Inc. All rights reserved.
//

import UIKit


public class FocusTvButton: UIButton {
    
    @IBInspectable public var focusedBackgroundColor: UIColor = .red
    @IBInspectable public var normalBackgroundColor: UIColor = .white
    @IBInspectable public var cornerRadius: CGFloat = 5.0
    @IBInspectable public var focusedScaleFactor: CGFloat = 1.2
    @IBInspectable public var focusedShadowRadius: CGFloat = 10
    @IBInspectable public var focusedShadowOpacity: Float = 0.25
    @IBInspectable public var shadowColor: CGColor = UIColor.black.cgColor
    @IBInspectable public var shadowOffSetFocused: CGSize = CGSize(width: 0, height: 27)
    @IBInspectable public var animationDuration: TimeInterval = 0.2
    @IBInspectable public var focusedTitleColor: UIColor = .white
    @IBInspectable public var normalTitleColor: UIColor = .white
    
    public override var buttonType: UIButtonType {
        return .custom
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override public func awakeFromNib() {
        setUpView()
    }
    
    override public func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            self.isFocused ? self.applyFocusedStyle() : self.applyUnfocusedStyle()
        }, completion: nil)
    }
    
    override public func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransform.identity
                self.layer.shadowOffset = CGSize(width: 0, height: 10)
            })
    }
    
    override public func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard isFocused else { return }
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransform(scaleX: self.focusedScaleFactor, y: self.focusedScaleFactor)
                self.layer.shadowOffset = self.shadowOffSetFocused
            })
    }
    
    override public func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard isFocused else { return }
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransform(scaleX: self.focusedScaleFactor, y: self.focusedScaleFactor)
                self.layer.shadowOffset = self.shadowOffSetFocused
            })
    }
    
    // MARK: - Private
    
    private func setUpView() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        backgroundColor = normalBackgroundColor
        setTitleColor(normalTitleColor, for: .normal)
        setTitleColor(focusedTitleColor, for: .focused)
        layer.shadowOpacity = self.focusedShadowOpacity
        layer.shadowRadius = self.focusedShadowRadius
        layer.shadowColor = self.shadowColor
        layer.shadowOffset = self.shadowOffSetFocused
    }
    
    private func applyFocusedStyle() {
        UIView.animate(
            withDuration: self.animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransform(scaleX: self.focusedScaleFactor, y: self.focusedScaleFactor)
                self.clipsToBounds = false
                self.backgroundColor = self.focusedBackgroundColor
            },
            completion: nil)
    }
    
    private func applyUnfocusedStyle() {
        UIView.animate(
            withDuration: self.animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.clipsToBounds = true
                self.transform = CGAffineTransform.identity
                self.backgroundColor = self.normalBackgroundColor
            },
            completion: nil)
    }
}

