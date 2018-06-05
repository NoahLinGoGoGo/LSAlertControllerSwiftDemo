# LSAlertControllerSwiftDemo
Swift Version For LSAlertController


### Demo【演示】
![演示](https://github.com/linshengqi/LSAlertController/blob/master/LSAlertController.gif)

### Examples【示例】

```
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

```


###  Differences With UIAlertController【和UIAlertController的区别】

```
     /** 按钮文字 */
    open var title: String = ""
    /** 按钮文字颜色，默认是StateNormal */
    open var textColor: UIColor = UIColor.black
    /** 按钮的点击事件 */
    typealias handlerBlock = (LSAlertAction) -> Void
    open var handler:handlerBlock?
    /** 按钮的初始化 */
    init(title: String, textColor: UIColor, handler: handlerBlock?) {
        super.init()
        self.title = title
        self.textColor = textColor
        self.handler = handler;
    }

```



### Manually【手动导入】
1. 通过 Clone or download 下载项目里面的 LSAlertController 文件夹内的 LSAlertController 和分类UIButton+Border.
2. 将 LSAlertController 内的源文件添加(拖放)到你的工程.



## License

LSAlertController is released under the MIT license. See LICENSE for details.
