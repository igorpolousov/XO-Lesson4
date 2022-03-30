//
//  ButtonsDesign.swift
//  XO-Lesson4
//
//  Created by Igor Polousov on 30.03.2022.
//

import Foundation
import UIKit

extension UIButton {
    
    func setup() {
        self.layer.cornerRadius = self.layer.frame.height / 4
        self.backgroundColor = UIColor.systemMint
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.darkGray, for: .selected)
        self.titleLabel?.font = UIFont(name: "Chalkduster", size: 15)
    }
}
