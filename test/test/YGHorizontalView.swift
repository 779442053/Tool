//
//  YGHorizontalView.swift
//  AllYoga-swift
//
//  Created by liwei on 2017/6/27.
//  Copyright © 2017年 liwei. All rights reserved.
//

import UIKit

class YGHorizontalView: UIControl {

    enum LayoutDirection {
        case left//从左往右布局
        case right//从右往左布局
        case center//从中间向两边布局
    }
    
    //默认从左往右布局
    var layoutDirection:LayoutDirection = .left
    //图片名称
    var imageName:String? {
    
        didSet {
            contentImageView.image = UIImage(named: imageName!)
            setNeedsLayout()
        }
    }
    //前半段文字
    var beforeHalfText:String? {
    
        didSet {
            beforeHalfLabel.text = beforeHalfText
            setNeedsLayout()
        }
    }
    //后半段文字
    var behindHalfText:String? {
    
        didSet {
            behindHalfLabel.text = behindHalfText
            setNeedsLayout()
        }
    }
    //前半段文字颜色
    var beforeHalfColor:UIColor? = UIColor.black
    //后半段文字颜色
    var behindHalfColor:UIColor? = UIColor.black
    //前半段文字大小
    var beforeHalfFont:UIFont? = UIFont.systemFont(ofSize: 15)
    //后半段文字大小
    var behindHalfFont:UIFont? = UIFont.systemFont(ofSize: 15)
    
    
    //前半段文字的align
    var beforeHalfAlign:NSTextAlignment = .left
    //后半段文字的align
    var behindHalfAlign:NSTextAlignment = .right
    //图片的填充模式
    var imageMode:UIViewContentMode = .scaleAspectFit
    //控件之间的间距，默认是5
    var padding:CGFloat = 5
    //图片高度
    var imageHeight:CGFloat  = 0
    
    
   private lazy var contentImageView:UIImageView! = {
    
        let image = UIImageView()
        image.contentMode = self.imageMode
        self.addSubview(image)
        return image
    }()
    
   private lazy var beforeHalfLabel:UILabel! = {
    
        let label = UILabel()
        label.textAlignment = self.beforeHalfAlign
        label.textColor = self.beforeHalfColor
        label.font = self.beforeHalfFont
        self.addSubview(label)
        return label
    }()
    
   private lazy var behindHalfLabel:UILabel! = {
        
        let label = UILabel()
        label.textAlignment = self.behindHalfAlign
        label.textColor = self.behindHalfColor
        label.font = self.behindHalfFont
        self.addSubview(label)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch layoutDirection {
        case .left:
            layoutFromLeft()
            break
        case .right:
            layoutFromRight()
            break;
        default:
            layoutFromCenter()
            break;
        }
        
    }
    
    private func layoutFromLeft() {
    
    
        let maxSize = frame.size
        var maxX = padding
        
        if let beforeText = beforeHalfText {
            let beforeSize = stringSize(string: beforeText, maxSize: maxSize, font: beforeHalfFont!, color: beforeHalfColor)
            beforeHalfLabel.center = CGPoint(x: maxX + beforeSize.width * 0.5, y: frame.height * 0.5)
            beforeHalfLabel.bounds = CGRect(x: 0, y: 0, width: beforeSize.width, height: beforeSize.height)
            maxX = beforeHalfLabel.frame.maxX + padding
        }
        
        if imageName != nil {
            let imageW =  imageHeight == 0 ? frame.height - 2 * 10 : imageHeight
            
           contentImageView.center = CGPoint(x: maxX + imageW * 0.5, y: frame.height * 0.5)
            contentImageView.bounds = CGRect(x: 0, y: 0, width: imageW, height: imageW)
            maxX = contentImageView.frame.maxX + padding
        }
        
        if let behindText = behindHalfText {
            let beforeSize = stringSize(string: behindText, maxSize: maxSize, font: behindHalfFont!, color: behindHalfColor)
            behindHalfLabel.center = CGPoint(x: maxX + beforeSize.width * 0.5, y: frame.height * 0.5)
            behindHalfLabel.bounds = CGRect(x: 0, y: 0, width: beforeSize.width, height: beforeSize.height)
        }
    }
    
    private func layoutFromRight() {
        let maxSize = frame.size
        var minX = padding
        
        if let behindText = behindHalfText {
            let beforeSize = stringSize(string: behindText, maxSize: maxSize, font: behindHalfFont!, color: behindHalfColor)
            behindHalfLabel.center = CGPoint(x: frame.width - minX - beforeSize.width * 0.5, y: frame.height * 0.5)
            behindHalfLabel.bounds = CGRect(x: 0, y: 0, width: beforeSize.width, height: beforeSize.height)
            minX = behindHalfLabel.frame.minX - padding
        }

        if imageName != nil {
            let imageW =  imageHeight == 0 ? frame.height - 2 * 10 : imageHeight
            
            contentImageView.center = CGPoint(x: minX - imageW * 0.5, y: frame.height * 0.5)
            contentImageView.bounds = CGRect(x: 0, y: 0, width: imageW, height: imageW)
            minX = contentImageView.frame.minX - padding
        }

        if let beforeText = beforeHalfText {
            let beforeSize = stringSize(string: beforeText, maxSize: maxSize, font: beforeHalfFont!, color: beforeHalfColor)
            beforeHalfLabel.center = CGPoint(x: minX - beforeSize.width * 0.5, y: frame.height * 0.5)
            beforeHalfLabel.bounds = CGRect(x: 0, y: 0, width: beforeSize.width, height: beforeSize.height)
        }
        
   }
    
    private func layoutFromCenter() {
        let maxSize = frame.size
        if imageName != nil {
            let imageW =  imageHeight == 0 ? frame.height - 2 * 10 : imageHeight
            
            contentImageView.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
            contentImageView.bounds = CGRect(x: 0, y: 0, width: imageW, height: imageW)
        }
        
        
        if let beforeText = beforeHalfText {
            let minX = imageName == nil ? frame.width * 0.5 : contentImageView.frame.minX
            
            let beforeSize = stringSize(string: beforeText, maxSize: maxSize, font: beforeHalfFont!, color: beforeHalfColor)
            beforeHalfLabel.center = CGPoint(x: minX - padding - beforeSize.width * 0.5, y: frame.height * 0.5)
            beforeHalfLabel.bounds = CGRect(x: 0, y: 0, width: beforeSize.width, height: beforeSize.height)
        }

        
        if let behindText = behindHalfText {
            let maxX = imageName == nil ? frame.width * 0.5 : contentImageView.frame.maxX

            let beforeSize = stringSize(string: behindText, maxSize: maxSize, font: behindHalfFont!, color: behindHalfColor)
            behindHalfLabel.center = CGPoint(x: maxX + padding + beforeSize.width * 0.5, y: frame.height * 0.5)
            behindHalfLabel.bounds = CGRect(x: 0, y: 0, width: beforeSize.width, height: beforeSize.height)
        }
        
    }
}

extension YGHorizontalView {

    public func stringLength(string:String?) -> Int {
        if string == nil {
            return 0
        }
        return string!.characters.count
    }
    
    public func stringSize(string:String?,maxSize:CGSize,font:UIFont, color:UIColor?) -> CGSize {
        var textColor:UIColor!
        
        if color == nil {
            textColor = UIColor.white
        }else {
            textColor = color!
        }
        var content:String = ""
        if  self.stringLength(string:string) > 0  {
            content = string!
        }
        let size = (content as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:font,NSBackgroundColorAttributeName:textColor], context: nil).size
        
        return size
    }

}
