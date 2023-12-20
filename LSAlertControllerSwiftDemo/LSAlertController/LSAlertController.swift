//
//  LSAlertController.swift
//  LSAlertControllerSwiftDemo
//
//  Created by 周结论 on 2018/5/30.
//  Copyright © 2018年 周结论. All rights reserved.
//

import UIKit

class LSAlertAction: NSObject {
    
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
    
    class func action(title: String, textColor: UIColor, handler: handlerBlock?) -> LSAlertAction {
        return LSAlertAction.init(title: title, textColor: textColor, handler: handler)
    }
    
    
}

class LSAlertController: UIViewController {
    //MARK:- 属性
    public enum LSAlertControllerStyle : Int {
        case actionSheet
        case alert
    }
     /** 白色Container的宽度，默认300 */
    open var containerW: CGFloat? {
        didSet {
            let containerX = containerView.frame.origin.x;
            let containerY = containerView.frame.origin.y;
            containerView.frame = CGRect(x: containerX, y: containerY,width: containerW!,height: containerH);
        }
    }
   /** 顶部标题 */
    open var titleText: String? {
        willSet {
            titleLabel.text = newValue
        }
    }
    /** 顶部子标题 */
    open var messageText: String? {
        willSet {
            messageLabel.text = newValue
        }
    }
    /** 样式，模仿苹果的两种样式ActionSheet和Alert供选择 */
    open var preferredStyle: LSAlertControllerStyle? {
        
        didSet {
            print("did set preferredStyle")
            if preferredStyle == .actionSheet {
                containerW = kScreenW
                containerH = 0
                containerView.layer.cornerRadius = 0.0
            } else {
                containerW = 300
                containerH = 160
            }
        }
    }
    
    var isFirst:Bool = false
    
    var actionItems: Array<LSAlertAction> = []
    var textFieldItems: Array<UITextField> = []
    

     //MARK:- Lazy
    lazy var containerView: UIView = {
        var containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 10.0
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    
    lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        titleLabel.textAlignment = .center
        titleLabel.textColor = RGB(r: 51, g: 51, b: 51)
        return titleLabel
    }()
    
    lazy var messageLabel: UILabel = {
        var messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 12.0)
        messageLabel.textAlignment = .center
        messageLabel.textColor = RGB(r: 51, g: 51, b: 51)
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    
     //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if !isFirst {
            if preferredStyle == .actionSheet {
                setupActionSheetStyleSubViews()
            } else {
                setupAlertStyleSubViews()
            }

        }
    }
    
    
    //MARK:- Public
    open func addAction(action: LSAlertAction) {
        actionItems.append(action)
    }
    
    open func addTextFieldWithConfigurationHandler(configurationHandler:(UITextField) -> Void) {
        if preferredStyle == .actionSheet {
            return
        }
        let textField = UITextField()
        textFieldItems.append(textField)
        configurationHandler(textField)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title: String?, message: String?, preferredStyle: LSAlertControllerStyle?) {
        super.init(nibName: nil, bundle: nil)
        initData(title, message, preferredStyle)
        initUI()
        
    }
    
    class func alertController(title: String?, message: String?, preferredStyle: LSAlertControllerStyle?) -> LSAlertController{
        return LSAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
    }
    
    func initData(_ title: String?,_ message: String?,_ preferredStyle: LSAlertControllerStyle?) {
        titleText = title
        messageText = message
        containerW = 300
        self.preferredStyle = preferredStyle
    }
    
    func initUI() {
        view.backgroundColor = UIColor.init(white: 0.0, alpha: 0.45)
        view.addSubview(containerView)
        
        if let titleCount = titleText?.count, titleCount > 0 {
            containerView.addSubview(titleLabel)
        }
        
        if let messageCount = messageText?.count, messageCount > 0 {
            containerView.addSubview(messageLabel)
        }
        
    }
    
    
    func setupActionSheetStyleSubViews()  {
        isFirst = true
        let actionCount = actionItems.count
        let buttonH: CGFloat = 50.0
        containerH += CGFloat(actionCount) * buttonH
        
        if titleText != nil || messageText != nil {
            containerH += buttonH
        }
        
        containerView.frame = CGRect(x: (kScreenW - containerW!) * 0.5, y: kScreenH - containerH, width: containerW!, height: containerH)
        
        if titleText != nil && messageText != nil {
            titleLabel.frame = CGRect(x: margin, y: 0, width: containerW! - 2 * margin, height: buttonH * 0.5)
            messageLabel.frame = CGRect(x: margin, y: buttonH * 0.5, width: containerW! - 2 * margin, height: buttonH * 0.5)
        }else{
            titleLabel.frame = CGRect(x: margin, y: 0, width: containerW! - 2 * margin, height: buttonH)
            messageLabel.frame = titleLabel.frame
        }
        
        for (i, action) in actionItems.enumerated() {
            let button = UIButton.init(type: .custom)
            button.setTitle(action.title, for: .normal)
            button.setTitleColor(action.textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            let count: CGFloat = CGFloat(actionCount) - CGFloat(i)
            if i == actionCount - 1 {
                button.frame = CGRect(x: 0, y: containerH - count * buttonH, width: containerW!, height: buttonH + 5)
                button.addTopBorder(color: RGBA(r: 102, g: 102, b: 102,a: 0.2), borderWidth: 5)
            } else {
                button.frame = CGRect(x: 0, y: containerH - count * buttonH, width: containerW!, height: buttonH)
            }
            
            button.layer.borderColor = RGB(r: 228, g: 228, b: 228).cgColor
            button.layer.borderWidth = 0.5
            button.tag = 100 + i
            containerView.addSubview(button)
        }
        
    }
    
    
    func setupAlertStyleSubViews()  {
        isFirst = true
        let actionCount = actionItems.count
        let textFieldCount = textFieldItems.count
        let textFieldW: CGFloat = containerW! - margin * 2
        let textFieldH: CGFloat = 40
        let buttonH: CGFloat = 50.0
        var buttonW: CGFloat = containerW! / CGFloat(actionCount)
        if actionCount > 2 {
            buttonW = containerW!
            containerH += CGFloat(actionCount) * buttonH - buttonH
        }
        containerH +=  CGFloat(textFieldCount) * textFieldH
        let messageTitleH  = messageText?.boundingRect(with: CGSize.init(width: containerW! - 2 * margin, height: CGFloat(MAXFLOAT)),options: NSStringDrawingOptions.usesLineFragmentOrigin,attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12.0)] ,context: nil).size.height
        
        if let messageLableH = messageTitleH{
            
            containerH += messageLableH
        }
        
        containerView.frame = CGRect(x: (kScreenW - containerW!) * 0.5, y: (kScreenH - containerH) * 0.5,width: containerW!, height: containerH)
        
        if let titleCount = titleText?.count, titleCount > 0 ,let messageCount = messageText?.count, messageCount > 0 {
            titleLabel.frame = CGRect(x: margin, y: margin, width: containerW! - 2 * margin, height: margin * 2)
            messageLabel.frame = CGRect(x: margin, y: margin * 4, width: containerW! - 2 * margin, height: messageTitleH!)
        } else {
            titleLabel.frame = CGRect(x: margin, y: margin * 4, width: containerW! - 2 * margin, height: margin * 2)
            if let messageLableH = messageTitleH{
                messageLabel.frame = CGRect(x: margin, y: margin * 4, width: containerW! - 2 * margin, height: messageLableH)
            }
            
        }
        
        
        for (i, textField) in textFieldItems.enumerated() {
            textField.borderStyle = .roundedRect
            textField.frame = CGRect(x: margin, y: messageLabel.frame.maxY + 10 + CGFloat(i) * textFieldH, width: textFieldW, height: textFieldH)
            containerView.addSubview(textField)
        }
        
        for (i,action) in actionItems.enumerated(){
            let button = UIButton.init(type: .custom)
            button.setTitle(action.title, for: .normal)
            button.setTitleColor(action.textColor, for: .normal)
            if actionCount > 2 {
                let i: CGFloat = CGFloat(actionCount) - CGFloat(i)
                button.frame = CGRect(x: 0, y: containerH - i * buttonH, width: buttonW, height: buttonH)
            } else {
                button.frame = CGRect(x: CGFloat(i) * buttonW, y: containerH - buttonH, width: buttonW, height: buttonH)
            }
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            button.layer.borderColor = RGB(r: 228, g: 228, b: 228).cgColor
            button.layer.borderWidth = 0.5
            button.tag = 100 + i
            containerView.addSubview(button)
            
        }
        
        
    }
    
    @objc fileprivate func buttonClick(button: UIButton) {
        let tag = button.tag - 100
        let action = actionItems[tag]
        if action.handler != nil {
            action.handler!(action)
        }
        dismiss()
        
    }
    
    
    func dismiss()  {
        containerH = 0;
        actionItems.removeAll()
        textFieldItems.removeAll()
        dismiss(animated: true, completion: nil)
    }
    
    func show() -> Void {
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        theTopviewControler().present(self, animated: true, completion: nil)
    }
    
    
    //MARK:- Private
    private func theTopviewControler() -> UIViewController {
        var rootVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        var parentVC = rootVC
        while getParentVC(parentVC: &parentVC, rootVC: rootVC) != nil {
            rootVC = parentVC
        }
        while rootVC is UINavigationController {
            rootVC = (rootVC as? UINavigationController)?.topViewController
        }
        return rootVC!;
    }
    
    
    private func getParentVC( parentVC: inout UIViewController?, rootVC: UIViewController?) ->UIViewController? {
        parentVC = rootVC?.presentedViewController
        return parentVC
    }
    fileprivate let margin: CGFloat = 15
    fileprivate var containerH: CGFloat = 160
    fileprivate let kScreenW  = UIScreen.main.bounds.size.width
    fileprivate let kScreenH  = UIScreen.main.bounds.size.height
    fileprivate let iosVersion = UIDevice.current.systemVersion
    
    fileprivate func RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor
    {
        return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
    }
    
    fileprivate func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor
    {
        return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
    }
    
    
}
