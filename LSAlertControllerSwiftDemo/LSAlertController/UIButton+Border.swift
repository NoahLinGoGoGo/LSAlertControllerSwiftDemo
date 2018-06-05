//
//  File.swift
//  LSAlertControllerSwiftDemo
//
//  Created by 周结论 on 2018/5/31.
//  Copyright © 2018年 周结论. All rights reserved.
//

import UIKit

extension UIButton {
    
    func addTopBorder(color: UIColor?, borderWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        layer.addSublayer(border)
    }
    
    func addBottomBorder(color: UIColor?, borderWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        layer.addSublayer(border)
    }
    
    func addLeftBorder(color: UIColor?, borderWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        layer.addSublayer(border)
    }
    
    func addRightBorder(color: UIColor?, borderWidth: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color?.cgColor
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        layer.addSublayer(border)
    }
    
}
