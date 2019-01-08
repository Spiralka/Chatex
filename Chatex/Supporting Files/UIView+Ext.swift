//
//  UIView+Ext.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
}

func async(queue: DispatchQueue = .main, after: Int = 0, _ block: @escaping ()->Void) {
    queue.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(after), execute: block)
}
