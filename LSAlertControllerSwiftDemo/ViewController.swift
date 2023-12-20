//
//  ViewController.swift
//  LSAlertControllerSwiftDemo
//
//  Created by 周结论 on 2018/5/30.
//  Copyright © 2018年 周结论. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func AlertStyle(_ sender: Any) {
        let alert = LSAlertController.init(title:"我是标题", message: "我是详细标题，可以多行", preferredStyle: .alert)
        let confirmAction = LSAlertAction.init(title: "确认", textColor: UIColor.red) { action in
            print("确认")
        }
        let cancelAction = LSAlertAction.init(title: "取消", textColor: UIColor.green) { action in
            print("取消")
        }
        alert.addAction(action: cancelAction)
        alert.addAction(action: confirmAction)
        alert.show()
    }
    
    
    @IBAction func AlertStyleWithTextField(_ sender: Any) {
        let alert = LSAlertController.init(title:"我是标题", message: "我是详细标题，可以多行", preferredStyle: .alert)
        let confirmAction = LSAlertAction.init(title: "确认", textColor: UIColor.red) { action in
            print("确认")
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "1111111"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "222222"
        }
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "333333"
        }
        alert.addAction(action: confirmAction)
        alert.show()
    }
    
    
    @IBAction func AlertStyleWithVerticalButtons(_ sender: Any) {
        
        let alert = LSAlertController.init(title:"我是标题", message: "我是详细标题，可以多行", preferredStyle: .alert)
        let confirmAction = LSAlertAction.init(title: "默认按钮总数", textColor: UIColor.red) { action in
            print("确认")
        }
        let cancelAction = LSAlertAction.init(title: "大于三个按钮", textColor: UIColor.green) { action in
            print("取消")
        }
        let threeAction = LSAlertAction.init(title: "就是竖着排列", textColor: UIColor.green) { action in
            print("取消")
        }
        alert.addAction(action: confirmAction)
        alert.addAction(action: cancelAction)
        alert.addAction(action: threeAction)
        alert.show()
    }
    
    
    @IBAction func AcitonSheet(_ sender: Any) {
        let alert = LSAlertController.init(title:nil, message: nil, preferredStyle: .actionSheet)
        let confirmAction = LSAlertAction.init(title: "确认", textColor: UIColor.red) { action in
            print("确认")
        }
        let cancelAction = LSAlertAction.init(title: "取消", textColor: UIColor.green) { action in
            print("取消")
        }
        let otherAction = LSAlertAction.init(title: "取消", textColor: UIColor.green) { action in
            print("取消")
        }
        alert.addAction(action: cancelAction)
        alert.addAction(action: confirmAction)
        alert.addAction(action: otherAction)
        alert.show()

    }
    
    @IBAction func AcitonSheetWithTitle(_ sender: Any) {
        let alert = LSAlertController.init(title:"标题", message: nil, preferredStyle: .actionSheet)
        let confirmAction = LSAlertAction.init(title: "确认", textColor: UIColor.red) { action in
            print("确认")
        }
        let cancelAction = LSAlertAction.init(title: "取消", textColor: UIColor.green) { action in
            print("取消")
        }
        let otherAction = LSAlertAction.init(title: "取消", textColor: UIColor.green) { action in
            print("取消")
        }
        alert.addAction(action: cancelAction)
        alert.addAction(action: confirmAction)
        alert.addAction(action: otherAction)
        alert.show()
    }
    
    
    @IBAction func AcitonSheetWithSubtitle(_ sender: Any) {
        let alert = LSAlertController.init(title:"标题", message: "我是详细标题，可以多行", preferredStyle: .actionSheet)
        let confirmAction = LSAlertAction.init(title: "确认", textColor: UIColor.red) { action in
            print("确认")
        }
        let cancelAction = LSAlertAction.init(title: "取消", textColor: UIColor.green) { action in
            print("取消")
        }
        let otherAction = LSAlertAction.init(title: "取消", textColor: UIColor.green) { action in
            print("取消")
        }
        alert.addAction(action: cancelAction)
        alert.addAction(action: confirmAction)
        alert.addAction(action: otherAction)
        alert.show()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

