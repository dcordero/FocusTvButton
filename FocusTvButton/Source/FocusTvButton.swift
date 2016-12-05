//
//  FocusTvButton.swift
//  FocusTvButton
//
//  Created by David Cordero on 01/09/16.
//  Copyright © 2016 David Cordero, Inc. All rights reserved.
//

import UIKit


public class FocusTvButton: UIButton {
    
    @IBInspectable public var focusedBackgroundColor: UIColor = .redColor()
    @IBInspectable public var normalBackgroundColor: UIColor = .whiteColor() {
        didSet {
            backgroundColor = normalBackgroundColor
        }
    }

    @IBInspectable public var cornerRadius: CGFloat = 5.0
    @IBInspectable public var focusedScaleFactor: CGFloat = 1.2
    @IBInspectable public var focusedShadowRadius: CGFloat = 10
    @IBInspectable public var focusedShadowOpacity: Float = 0.25
    @IBInspectable public var shadowColor: CGColor = UIColor.blackColor().CGColor
    @IBInspectable public var shadowOffSetFocused: CGSize = CGSize(width: 0, height: 27)
    @IBInspectable public var animationDuration: NSTimeInterval = 0.2
    @IBInspectable public var focusedTitleColor: UIColor = .whiteColor()
    @IBInspectable public var normalTitleColor: UIColor = .whiteColor()
    
    public override var buttonType: UIButtonType {
        return .Custom
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
    
    override public func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({
            self.focused ? self.applyFocusedStyle() : self.applyUnfocusedStyle()
        }, completion: nil)
    }
    
    override public func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        UIView.animateWithDuration(
            animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransformIdentity
                self.layer.shadowOffset = CGSize(width: 0, height: 10)
            })
    }
    
    override public func pressesCancelled(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        guard focused else { return }
        UIView.animateWithDuration(
            animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransformMakeScale(self.focusedScaleFactor, self.focusedScaleFactor)
                self.layer.shadowOffset = self.shadowOffSetFocused
            })
    }
    
    override public func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
        guard focused else { return }
        UIView.animateWithDuration(
            animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransformMakeScale(self.focusedScaleFactor, self.focusedScaleFactor)
                self.layer.shadowOffset = self.shadowOffSetFocused
            })
    }
    
    // MARK: - Private
    
    private func setUpView() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        backgroundColor = normalBackgroundColor
        setTitleColor(normalTitleColor, forState: .Normal)
        setTitleColor(focusedTitleColor, forState: .Focused)
        layer.shadowOpacity = self.focusedShadowOpacity
        layer.shadowRadius = self.focusedShadowRadius
        layer.shadowColor = self.shadowColor
        layer.shadowOffset = self.shadowOffSetFocused
    }
    
    private func applyFocusedStyle() {
        UIView.animateWithDuration(
            self.animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.transform = CGAffineTransformMakeScale(self.focusedScaleFactor, self.focusedScaleFactor)
                self.clipsToBounds = false
                self.backgroundColor = self.focusedBackgroundColor
            },
            completion: nil)
    }
    
    private func applyUnfocusedStyle() {
        UIView.animateWithDuration(
            self.animationDuration,
            animations: {
                [weak self] in
                guard let `self` = self else { return }
                self.clipsToBounds = true
                self.transform = CGAffineTransformIdentity
                self.backgroundColor = self.normalBackgroundColor
            },
            completion: nil)
    }
}

