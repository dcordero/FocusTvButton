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

        let button = FocusTvButton(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        button.focusedBackgroundColor = .green
        button.normalBackgroundColor = .lightGray
        button.cornerRadius = button.bounds.width / 2
        button.setTitle("Button", for: .normal)
        
        view.addSubview(button)
    }
}
