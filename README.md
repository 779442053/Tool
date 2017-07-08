# Tool
一些常用的工具类，后续工作中使用到的可以公共使用的工具类都会添加进来

1.YGIAPTool是内购方法的简易封装，可以作为一个工具类，外界只需要调用其中的create方法就可以创建商品请求，进行商品支付

2.新增了一些项目中常用的分类方法

```
view的拓展,主要罗列了一下几个
```
####2.1.1根据颜色生成相应的图片
```
 func createImage(color:UIColor!,rect:CGRect!) -> UIImage
```

####2.1.2根据颜色生成细线
```
func lineImage(color:UIColor!) -> UIImage
```

####2.1.3生成带圆角的矩形图片
```
func getRectWithCorner(right:Bool,color:UIColor) -> UIImage
```

####2.1.4定制加载提示图，需要导入MBProgressHUD这个库
```
public func showLoadingView()
public func hideLoadingView()
public func showLoadingView(message:String) 
```


####2.2.1 根据十六进制生成颜色值
```
class func color(hexString:String!) -> UIColor
```

####2.2.2 根据R,G,B值生成颜色值
```
 class func RGB(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor
```

####2.3.1 获取屏幕宽高
```
 struct ScreenSize {
     static  let screenWidth = UIScreen.main.bounds.width
     static let screenHeight = UIScreen.main.bounds.height
    }
```

####2.3.2 根据宽高适配屏幕（以iPhone6为模板）
```
 class func widthToScale(width:CGFloat) -> CGFloat
 
 class func heightToScale(height:CGFloat) -> CGFloat

 func scaleToWidth(size:CGFloat) -> CGFloat
 
 func scaleToHeight(size:CGFloat) -> CGFloat
```

####2.3.3将数据转换成json字符串
```
public func jsonString() -> String
```

####2.4 自定义navigationBar(实则隐藏系统的，自己定制)
```
func createNavigationBar(leftImageName:String?,titleText:String?,titleFont:CGFloat,titleColor:UIColor?,titleImageName:String?,rightImageName:String?,alpha:CGFloat,textAlpha:CGFloat) -> UIView
```

####2.5.1 计算字符串的尺寸
```
public func stringSize(maxSize:CGSize,font:UIFont, color:UIColor?) -> CGSize
```

####2.5.2 将字符串转换成富文本
```
 public func transformToRichText(font:UIFont,color:UIColor,linspace:CGFloat,kern:CGFloat) -> NSMutableAttributedString
```

####2.5.3 计算富文本的尺寸
```
 public func richTextSize(maxSize:CGSize,font:UIFont,color:UIColor?,linespace:CGFloat,kern:CGFloat) -> CGSize
```


ps:这里只是项目中常用的一些分类方法，在这里记录下来


