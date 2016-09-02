//
//  ViewController.swift
//  Example
//
//  Created by David Cordero on 02/09/16.
//  Copyright © 2016 David Cordero. All rights reserved.
//

import UIKit
import FocusTvButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = FocusTvButton(frame: CGRectMake(100, 100, 200, 200))
        button.focusedBackgroundColor = .greenColor()
        button.normalBackgroundColor = .lightGrayColor()
        button.setTitle("Button", forState: .Normal)
        view.addSubview(button)
    }
}

