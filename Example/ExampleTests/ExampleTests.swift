//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by David Cordero on 08.12.17.
//  Copyright © 2017 David Cordero. All rights reserved.
//

import XCTest
import Snap_swift
import FocusTvButton

class ExampleTests: XCTestCase {
    
    static var stub_isFocused: Bool = false
    
    override func setUp() {
        super.setUp()
        isRecording = true
    }
    
    func test_BasicFocusedLayout() {
        // Given
        ExampleTests.stub_isFocused = true
        
        // When
        let sut = configuredFocusTvButton()

        // Then
        expect(sut).toMatchSnapshot()
    }
    
    func test_BasicUnfocusedLayout() {
        // Given
        ExampleTests.stub_isFocused = false

        // When
        let sut = configuredFocusTvButton()

        // Then
        expect(sut).toMatchSnapshot()
    }
    
    func test_GradientBackgroundWhenFocused() {
        // Given
        ExampleTests.stub_isFocused = true
        
        // When
        let sut = configuredFocusTvButton()
        sut.focusedBackgroundEndColor = .green
        sut.gradientStartPoint = .zero
        sut.gradientEndPoint = CGPoint(x: 0, y: 1)
        
        sut.setNeedsFocusUpdate()
        sut.updateFocusIfNeeded()
        
        // Then
        expect(sut).toMatchSnapshot()
    }
    
    func test_GradientBackgroundWhenUnfocused() {
        // Given
        ExampleTests.stub_isFocused = false
        
        // When
        let sut = configuredFocusTvButton()
        sut.normalBackgroundEndColor = .purple
        sut.gradientStartPoint = .zero
        sut.gradientEndPoint = CGPoint(x: 0.5, y: 0.5)
        
        sut.setNeedsFocusUpdate()
        sut.updateFocusIfNeeded()
        
        // Then
        expect(sut).toMatchSnapshot()
    }
    
    // Private
    
    private func configuredFocusTvButton() -> FocusTvButton {
        let button = FocusTvButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        button.focusedBackgroundColor = .red
        button.normalBackgroundColor = .blue
        button.focusedTitleColor = .black
        button.normalTitleColor = .orange
        button.focusedScaleFactor = 2
        button.cornerRadius = 30
        
        button.setTitle("Normal", for: .normal)
        button.setTitle("Focused", for: .focused)
        
        return button
    }
}

extension FocusTvButton {
    open override var isFocused: Bool {
        return ExampleTests.stub_isFocused
    }
}
