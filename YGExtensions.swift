//
//  YGExtensions.swift
//  AllYoga-swift
//
//  Created by liwei on 2017/6/24.
//  Copyright © 2017年 liwei. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

//view的扩展
extension UIView {
//根据尺寸以及颜色生成响应的图片
    func createImage(color:UIColor!,rect:CGRect!) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(color.cgColor)
        ctx?.fill(rect)
      let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage!
    }
    //根据颜色生成细线图片
    func lineImage(color:UIColor!) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(color.cgColor)
        ctx?.fill(rect)
        let lineImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return lineImage!
    }
    
    //生成带圆角的矩形
    func getRectWithCorner(right:Bool,color:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        let path = UIBezierPath()
        if right {
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: frame.width - frame.height * 0.5, y: 0))
            path.addArc(withCenter: CGPoint(x:frame.width - frame.height * 0.5,y:frame.height * 0.5), radius: frame.height * 0.5, startAngle: CGFloat(3 * Double.pi / 2), endAngle: CGFloat(5 * Double.pi / 2), clockwise: true)
            path.addLine(to: CGPoint(x: 0, y: frame.height))
            path.close()
        }else {
            path.move(to: CGPoint(x: frame.height * 0.5, y: 0))
            path.addLine(to: CGPoint(x: frame.width - scaleToHeight(size: 5), y: 0))
            path.addArc(withCenter: CGPoint(x:frame.width - scaleToHeight(size: 5),y:scaleToHeight(size: 5)), radius: scaleToHeight(size: 5), startAngle: CGFloat(3 * Double.pi / 2), endAngle: CGFloat(2 * Double.pi), clockwise: true)
            path.addLine(to: CGPoint(x: frame.width, y: frame.height - scaleToHeight(size: 5)))
            path.addArc(withCenter: CGPoint(x:frame.width - scaleToHeight(size: 5),y:frame.height - scaleToHeight(size: 5)), radius: scaleToHeight(size: 5), startAngle: CGFloat(2 * Double.pi), endAngle: CGFloat(5 * Double.pi / 2), clockwise: true)
            path.addLine(to: CGPoint(x: frame.height * 0.5, y: frame.height))
            path.addArc(withCenter: CGPoint(x:frame.height * 0.5,y:frame.height * 0.5), radius: frame.size.height * 0.5, startAngle: CGFloat(5 * Double.pi / 2), endAngle: CGFloat(7 * Double.pi / 2), clockwise: true)
        }
        color.setFill()
        ctx?.addPath(path.cgPath)
        ctx?.fillPath()
        let opaueImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return opaueImage!
    }
    
    func getViewCenterY() -> CGFloat {
        return self.getViewHeight() * 0.5
    }
    
    func getViewCenterX() -> CGFloat {
        return self.getViewWidth() * 0.5
    }
    
    func getViewWidth() -> CGFloat {
        return self.frame.width
    }
    
    func getViewHeight() -> CGFloat {
        return self.frame.height
    }
    
    public func showLoadingView() {
    
        MBProgressHUD.hide(for: self, animated: true)
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.isUserInteractionEnabled = false
        hud.hide(animated: true, afterDelay: 60)
    }
    
    public func hideLoadingView() {
    
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    public func showLoadingView(message:String) {
    
        MBProgressHUD.hide(for: self, animated: true)
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.contentColor = UIColor.white
        hud.bezelView.backgroundColor = UIColor.black
        hud.mode = .text
        hud.label.text = message
        hud.setValue(2, forKeyPath: "_label.numberOfLines")
        hud.isUserInteractionEnabled = false
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
}

//颜色扩展
extension UIColor {
    class func color(hexString:String!) -> UIColor {
    
        var cString:String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if cString.characters.count < 6 {
            return UIColor.defaultColor()
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(from:cString.index(cString.startIndex, offsetBy: 1) )
        }
        if cString.characters.count != 6 {
            return UIColor.defaultColor()
        }
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to:2)
        
        var r:CUnsignedInt = 0,g:CUnsignedInt = 0,b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
       return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    class func defaultColor() ->UIColor {
        return UIColor.white
    }
    
    class func RGB(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
        return UIColor(red:r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}

//拓展，主要获取屏幕宽高，以及屏幕适配
extension NSObject {
    
    struct ScreenSize {
     static  let screenWidth = UIScreen.main.bounds.width
     static let screenHeight = UIScreen.main.bounds.height
    }
    
    class func widthToScale(width:CGFloat) -> CGFloat {
    
        return width * kScreenW / 365
    }
    
    class func heightToScale(height:CGFloat) -> CGFloat {
        return height * kScreenH / 667
    }
    
    func scaleToWidth(size:CGFloat) -> CGFloat {
        return size * kScreenW / 365
    }
    
    func scaleToHeight(size:CGFloat) -> CGFloat {
        return size * kScreenH / 667
    }
    
    //将数据转换成json
    public func jsonString() -> String {
    
        var jsonStr:String?
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            
            jsonStr = String.init(data: jsonData, encoding: .utf8)
        } catch  {
           jsonStr = self as? String
        }

        return jsonStr!
    }

}

//在控制器的分类中创建自定义导航栏
extension UIViewController {

    struct Constants {
        static let kNavBarTag = 666
        static let kOpaueViewTag = 333
        static let kTextLabelTag = 999
        static let kBadgeViewTag = 888
        static let kBgViewTag = 222
        static let kShareView = 111
    }
    
    func createNavigationBar(leftImageName:String?,titleText:String?,titleFont:CGFloat,titleColor:UIColor?,titleImageName:String?,rightImageName:String?,alpha:CGFloat,textAlpha:CGFloat) -> UIView {
        let navBar = UIView(frame: CGRect(x: 0, y: 0, width: UIViewController.ScreenSize.screenWidth, height: 64))
        navBar.backgroundColor = UIColor.clear
        navBar.tag = Constants.kNavBarTag
        
        let opaueView = UIView(frame: navBar.bounds)
        opaueView.backgroundColor = UIColor.RGB(r: 102, g: 102, b: 102, a: 1)
        opaueView.alpha = alpha
        opaueView.tag = Constants.kOpaueViewTag
        navBar.addSubview(opaueView)
        
        let centerY:CGFloat = 20 + 44 * 0.5
        
        if let navTitle = titleText {
            let textLabel = UILabel()
            textLabel.center = CGPoint(x: navBar.getViewCenterX(), y: centerY)
            textLabel.bounds = CGRect(x: 0, y: 0, width: navBar.getViewWidth() - 2 * 50, height: 30)
            textLabel.textAlignment = .center
            textLabel.textColor = titleColor
            textLabel.text = navTitle
            textLabel.alpha = textAlpha
            textLabel.font = UIFont.systemFont(ofSize: titleFont)
            navBar.addSubview(textLabel)
            textLabel.tag = Constants.kTextLabelTag
        }
        
        if let titleImage = titleImageName {
            let titleImageView = UIImageView()
            titleImageView.center = CGPoint(x: navBar.getViewCenterX(), y: centerY)
            titleImageView.bounds = CGRect(x: 0, y: 0, width: 27, height: 27)
            titleImageView.image = UIImage(named: titleImage)
            navBar.addSubview(titleImageView)
        }
        
        if let leftImage = leftImageName {
            let badgeView = YGBadgeView()
            badgeView.center = CGPoint(x: 10 + 32 * 0.5, y: centerY)
            badgeView.bounds = CGRect(x: 0, y: 0, width: 32, height: 27)
            badgeView.imageName = leftImage
            badgeView.badgeColor = UIColor.color(hexString: "fb9966")
            badgeView.showBadge = false
            badgeView.addTarget(target: self, action: #selector(UIViewController.didClickNavLeftItem))
            navBar.addSubview(badgeView)
            badgeView.tag = Constants.kBadgeViewTag
        }
        
        if let rightImage = rightImageName {
            let rightItem = UIButton(type: .custom)
            rightItem.center = CGPoint(x:navBar.getViewWidth() - 15 - 27 * 0.5,y:centerY)
            rightItem.bounds = CGRect(x: 0, y: 0, width: 27, height: 27)
            rightItem.setImage(UIImage(named:rightImage), for: .normal)
            rightItem.addTarget(self, action: #selector(UIViewController.didClickNavRightItem), for: .touchUpInside)
            navBar.addSubview(rightItem)
        }
        view.addSubview(navBar)
        return navBar
    }
    
    public func didClickNavRightItem() {
    
    }
    
    public func didClickNavLeftItem() {
    
    }
    
    public func updateOpaueViewAlpha(alpha:CGFloat) {
    
        let navBar = view.viewWithTag(Constants.kNavBarTag)
        let opaueView = navBar?.viewWithTag(Constants.kOpaueViewTag)
        opaueView?.alpha = alpha
        
        let textLabel = navBar?.viewWithTag(Constants.kTextLabelTag)
        textLabel?.alpha = alpha
    }
    
    
}

//字符串分类
extension String {

    //计算字符串的长度
    public func stringLength() -> Int {
    
        return self.characters.count
    }
    
    //计算字符串的尺寸
    public func stringSize(maxSize:CGSize,font:UIFont, color:UIColor?) -> CGSize {
        var textColor:UIColor!
        
        if color == nil {
            textColor = UIColor.defaultColor()
        }else {
            textColor = color!
        }
        var content:String = ""
        if  self.stringLength() > 0  {
            content = self
        }
        let size = (content as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:font,NSBackgroundColorAttributeName:textColor], context: nil).size
       
        return size
    }
    //根据条件生成富文本需要的属性
    private func attributes(font:UIFont,color:UIColor,linespace:CGFloat,kern:CGFloat) -> [String:Any] {
    
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.lineSpacing = linespace
        return [NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSKernAttributeName:kern]
    }
    
    //计算富文本的尺寸
    public func richTextSize(maxSize:CGSize,font:UIFont,color:UIColor?,linespace:CGFloat,kern:CGFloat) -> CGSize {
    
        var textColor:UIColor!
        if let tco = color {
            textColor = tco
        }else {
            textColor = UIColor.darkGray
        }
        var content = ""
        if self.stringLength() > 0 {
            content = self
        }
        let dic = attributes(font: font, color: textColor, linespace: linespace, kern: kern)
        
        return (content as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: dic, context: nil).size
    }
    //将字符串转换成富文本
    public func transformToRichText(font:UIFont,color:UIColor,linspace:CGFloat,kern:CGFloat) -> NSMutableAttributedString {
        let dic = attributes(font: font, color: color, linespace: linspace, kern: kern)
        var content = ""
        if self.stringLength() > 0 {
            content = self
        }
        
        let attributedStr = NSMutableAttributedString(string: content)
        attributedStr.addAttributes(dic, range: NSRange.init(location: 0, length: content.stringLength()))
        return attributedStr
    }
    
}

//增加字体大小的类方法，主要是为了写方便
extension UIFont {

    public class func fontSystem(font:CGFloat) -> UIFont {
    
        return UIFont.systemFont(ofSize:widthToScale(width: font))
    }
}

//按钮的类方法,主要是为了书写方便
extension UIButton {

    public func titleFont(font:CGFloat) {
    
        titleLabel?.font = UIFont.systemFont(ofSize: font)
    }
    
    public func titleColor(color:UIColor,state:UIControlState) {
    
        setTitleColor(color, for: state)
    }
    
    public func title(text:String,state:UIControlState) {
        setTitle(text, for: state)
    }
    
    public func image(imageName:String,state:UIControlState) {
    
        setImage(UIImage(named:imageName), for: state)
    }
    
    public func backgroundImage(imageName:String,state:UIControlState) {
        setBackgroundImage(UIImage(named:imageName), for: state)
    }
    
    open override var isHighlighted: Bool {
        
        set {
            
        }
        get {
            
            return false
        }
    }

}


