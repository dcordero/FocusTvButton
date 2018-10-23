//
//  FocusTvButtonTests.swift
//  FocusTvButtonTests
//
//  Created by David Cordero on 11.12.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import FocusTvButton

class FocusTvButtonTests: FBSnapshotTestCase {
    
    static var stub_isFocused: Bool = false
    static var stub_isSelected: Bool = false
    
    override func setUp() {
        super.setUp()
        // recordMode = true
    }
    
    func test_BasicFocusedLayout() {
        // Given
        FocusTvButtonTests.stub_isFocused = true
        FocusTvButtonTests.stub_isSelected = false

        // When
        let sut = configuredFocusTvButton()
        
        // Then
        FBSnapshotVerifyView(sut)
    }
    
    func test_BasicUnfocusedLayout() {
        // Given
        FocusTvButtonTests.stub_isFocused = false
        FocusTvButtonTests.stub_isSelected = false

        // When
        let sut = configuredFocusTvButton()
        
        // Then
        FBSnapshotVerifyView(sut)
    }
    
    func test_BasicSelectedAndUnfocusedLayout() {
        // Given
        FocusTvButtonTests.stub_isFocused = false
        FocusTvButtonTests.stub_isSelected = true

        // When
        let sut = configuredFocusTvButton()
        
        // Then
        FBSnapshotVerifyView(sut)
    }
    
    func test_BasicSelectedAndFocusedLayout() {
        // Given
        FocusTvButtonTests.stub_isFocused = true
        FocusTvButtonTests.stub_isSelected = true
        
        // When
        let sut = configuredFocusTvButton()
        
        // Then
        FBSnapshotVerifyView(sut)
    }
    func test_GradientBackgroundWhenFocused() {
        // Given
        FocusTvButtonTests.stub_isFocused = true
        FocusTvButtonTests.stub_isSelected = false

        // When
        let sut = configuredFocusTvButton()
        sut.focusedBackgroundEndColor = .green
        sut.gradientStartPoint = .zero
        sut.gradientEndPoint = CGPoint(x: 0, y: 1)
        
        sut.setNeedsFocusUpdate()
        sut.updateFocusIfNeeded()
        
        // Then
        FBSnapshotVerifyView(sut)
    }
    
    func test_GradientBackgroundWhenUnfocused() {
        // Given
        FocusTvButtonTests.stub_isFocused = false
        FocusTvButtonTests.stub_isSelected = false

        // When
        let sut = configuredFocusTvButton()
        sut.normalBackgroundEndColor = .purple
        sut.gradientStartPoint = .zero
        sut.gradientEndPoint = CGPoint(x: 0.5, y: 0.5)
        
        sut.setNeedsFocusUpdate()
        sut.updateFocusIfNeeded()
        
        // Then
        FBSnapshotVerifyView(sut)
    }
    
    func test_GradientBackgroundWhenSelectedAndUnfocused() {
        // Given
        FocusTvButtonTests.stub_isFocused = false
        FocusTvButtonTests.stub_isSelected = true
        
        // When
        let sut = configuredFocusTvButton()
        sut.selectedBackgroundEndColor = .brown
        sut.gradientStartPoint = .zero
        sut.gradientEndPoint = CGPoint(x: 0.5, y: 0.5)
        
        sut.setNeedsFocusUpdate()
        sut.updateFocusIfNeeded()
        
        // Then
        FBSnapshotVerifyView(sut)
    }
    
    // Private
    
    private func configuredFocusTvButton() -> FocusTvButton {
        let button = FocusTvButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        button.focusedBackgroundColor = .red
        button.normalBackgroundColor = .blue
        button.selectedBackgroundColor = .yellow
        button.focusedTitleColor = .black
        button.normalTitleColor = .orange
        button.focusedScaleFactor = 2
        button.cornerRadius = 30
        
        button.setTitle("Normal", for: .normal)
        button.setTitle("Focused", for: .focused)
        button.setTitle("Selected", for: .selected)
        
        return button
    }
}

extension FocusTvButton {
    open override var isFocused: Bool {
        return FocusTvButtonTests.stub_isFocused
    }
    
    open override var isSelected: Bool {
        set {
            super.isSelected = isSelected
        }
        get {
            return FocusTvButtonTests.stub_isSelected
        }
    }
}
