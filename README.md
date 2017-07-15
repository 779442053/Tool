# Tool
一些常用的工具类，后续工作中使用到的可以公共使用的工具类都会添加进来

1.YGIAPTool是内购方法的简易封装，可以作为一个工具类，外界只需要调用其中的create方法就可以创建商品请求，进行商品支付

2.新增了一些项目中常用的分类方法

3.修改部分：YGIAPTool新增OC的封装工具，并且对相关逻辑处理做了优化调整

4.新增了一个控件类，作用是实现图片文字同时显示



```
view的拓展,主要罗列了一下几个
```
#### 2.1.1根据颜色生成相应的图片
```
 func createImage(color:UIColor!,rect:CGRect!) -> UIImage
```

#### 2.1.2根据颜色生成细线
```
func lineImage(color:UIColor!) -> UIImage
```

#### 2.1.3生成带圆角的矩形图片
```
func getRectWithCorner(right:Bool,color:UIColor) -> UIImage
```

#### 2.1.4定制加载提示图，需要导入MBProgressHUD这个库
```
public func showLoadingView()
public func hideLoadingView()
public func showLoadingView(message:String) 
```


#### 2.2.1 根据十六进制生成颜色值
```
class func color(hexString:String!) -> UIColor
```

#### 2.2.2 根据R,G,B值生成颜色值
```
 class func RGB(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor
```

#### 2.3.1 获取屏幕宽高
```
 struct ScreenSize {
     static  let screenWidth = UIScreen.main.bounds.width
     static let screenHeight = UIScreen.main.bounds.height
    }
```

#### 2.3.2 根据宽高适配屏幕（以iPhone6为模板）
```
 class func widthToScale(width:CGFloat) -> CGFloat
 
 class func heightToScale(height:CGFloat) -> CGFloat

 func scaleToWidth(size:CGFloat) -> CGFloat
 
 func scaleToHeight(size:CGFloat) -> CGFloat
```

#### 2.3.3将数据转换成json字符串
```
public func jsonString() -> String
```

#### 2.4 自定义navigationBar(实则隐藏系统的，自己定制)
```
func createNavigationBar(leftImageName:String?,titleText:String?,titleFont:CGFloat,titleColor:UIColor?,titleImageName:String?,rightImageName:String?,alpha:CGFloat,textAlpha:CGFloat) -> UIView
```

#### 2.5.1 计算字符串的尺寸
```
public func stringSize(maxSize:CGSize,font:UIFont, color:UIColor?) -> CGSize
```

#### 2.5.2 将字符串转换成富文本
```
 public func transformToRichText(font:UIFont,color:UIColor,linspace:CGFloat,kern:CGFloat) -> NSMutableAttributedString
```

#### 2.5.3 计算富文本的尺寸
```
 public func richTextSize(maxSize:CGSize,font:UIFont,color:UIColor?,linespace:CGFloat,kern:CGFloat) -> CGSize
```


ps:这里只是项目中常用的一些分类方法，在这里记录下来



#### 3.新增类的主要属性和方法介绍

###### 3.1 主要属性

```
//默认从左往右布局
var layoutDirection:LayoutDirection = .left

```
这个设置布局方向：主要有三个，从左往右(.left),从右往左(.right)，从中间向两边(.center)

```
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

```

##### 3.2 核心方法

从左往右布局
```  private func layoutFromLeft() ```

从右往左布局
```  private func layoutFromRight() ```

从中间向两边布局
``` private func layoutFromCenter() ```
















