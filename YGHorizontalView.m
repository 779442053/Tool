//
//  YGHorizontalView.m
//  AllYoga
//
//  Created by liwei on 2017/7/18.
//  Copyright © 2017年 biyunkeji. All rights reserved.
//

#import "YGHorizontalView.h"

@interface YGHorizontalView ()
/** 左边文字 */
@property (nonatomic,strong) UILabel *frontLabel;

/** 中间图片 */
@property (nonatomic,strong) UIImageView *middleImageView;

/**  右边文字 */
@property (nonatomic,strong) UILabel *trailLabel;

@end

@implementation YGHorizontalView

-(UILabel *)trailLabel{
    if (!_trailLabel){
        _trailLabel = [[UILabel alloc] init];
        _trailLabel.textAlignment = self.trailAlign;
        _trailLabel.font = self.trailFont;
        _trailLabel.textColor = self.trailColor;
        [self addSubview:_trailLabel];
    }
    return _trailLabel;
}

-(UILabel *)frontLabel{
    if (!_frontLabel){
        _frontLabel = [[UILabel alloc] init];
        _frontLabel.textColor = self.frontColor;
        _frontLabel.font = self.frontFont;
        _frontLabel.textAlignment = self.frontAlign;
        [self addSubview:_frontLabel];
    }
    return _frontLabel;
}

-(UIImageView *)middleImageView{
    if (!_middleImageView){
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.contentMode = self.contentMode;
        [self addSubview:_middleImageView];
    }
    return _middleImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self initProperties];
    }
    return  self;
}

- (instancetype)init {

    if (self = [super init]) {
        [self initProperties];
    }
    return self;
}

- (void)initProperties {

    self.frontFont = [UIFont systemFontOfSize:15];
    self.frontAlign = NSTextAlignmentLeft;
    self.frontColor = [UIColor blackColor];
    
    self.trailFont = [UIFont systemFontOfSize:15];
    self.trailColor = [UIColor blackColor];
    self.trailAlign = NSTextAlignmentLeft;
    
    self.contentMode = UIViewContentModeScaleAspectFit;
    
    self.layoutDirection = YGHorizontalLayoutDirectionLeft;
    
    self.imageViewInset = UIEdgeInsetsMake(5, 10, 5, 10);
    
    self.textInset = UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)setFrontContent:(NSString *)frontContent {

    _frontContent = frontContent;
    [self setNeedsLayout];
}

- (void)setTrailContent:(NSString *)trailContent {

    _trailContent = trailContent;
    [self setNeedsLayout];
}

- (void)setImageName:(NSString *)imageName {

    _imageName = imageName;
    self.middleImageView.image = [UIImage imageNamed:imageName];
    [self setNeedsLayout];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    switch (self.layoutDirection) {
        case YGHorizontalLayoutDirectionLeft:
            [self layoutSubviewsFromFront];
            break;
        case YGHorizontalLayoutDirectionRight:
            [self layoutSubviewsFromTrail];
            break;
        default:
            [self layoutSubviewsFromMiddle];
            break;
    }
}

//从左往右布局
- (void)layoutSubviewsFromFront {

    CGFloat maxX = self.textInset.left;
    if (self.frontContent || self.frontContent.length > 0) {
        CGSize frontSize = [self.frontContent boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.frontFont,NSForegroundColorAttributeName:self.frontColor} context:nil].size;
        self.frontLabel.center = CGPointMake(maxX + frontSize.width * 0.5, self.frame.size.height * 0.5);
        self.frontLabel.bounds = CGRectMake(0, 0, frontSize.width, frontSize.height);
        maxX = CGRectGetMaxX(self.frontLabel.frame);
    }
    
    if (self.imageName && self.imageName.length > 0) {
        self.middleImageView.center = CGPointMake(maxX + self.imageViewInset.left + (self.frame.size.height - self.imageViewInset.top - self.imageViewInset.left) * 0.5, self.frame.size.height * 0.5);
        self.middleImageView.bounds = CGRectMake(0, 0, self.frame.size.height - self.imageViewInset.top - self.imageViewInset.left, self.frame.size.height - self.imageViewInset.top - self.imageViewInset.left);
        maxX = CGRectGetMaxX(self.middleImageView.frame);
    }
    
    if (self.trailContent || self.trailContent.length > 0) {
         CGSize trailSize = [self.trailContent boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.trailFont,NSForegroundColorAttributeName:self.trailColor} context:nil].size;
        self.trailLabel.center = CGPointMake(maxX + self.imageViewInset.right + trailSize.width * 0.5, self.frame.size.height * 0.5);
        self.trailLabel.bounds = CGRectMake(0, 0, trailSize.width, trailSize.height);
    }
    
}
//从中间向两边
- (void)layoutSubviewsFromMiddle {
    CGFloat maxX = self.textInset.left;
    
    if (self.imageName && self.imageName.length > 0) {
        self.middleImageView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
        self.middleImageView.bounds = CGRectMake(0, 0, self.frame.size.height - self.imageViewInset.top - self.imageViewInset.left, self.frame.size.height - self.imageViewInset.top - self.imageViewInset.left);
    }
    
    if (self.frontContent || self.frontContent.length > 0) {
        maxX = CGRectGetMinX(self.middleImageView.frame);
        CGSize frontSize = [self.frontContent boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.frontFont,NSForegroundColorAttributeName:self.frontColor} context:nil].size;
        self.frontLabel.center = CGPointMake(maxX - frontSize.width * 0.5, self.frame.size.height * 0.5);
        self.frontLabel.bounds = CGRectMake(0, 0, frontSize.width, frontSize.height);
    }
    
    if (self.trailContent || self.trailContent.length > 0) {
        maxX = CGRectGetMaxX(self.middleImageView.frame);
        CGSize trailSize = [self.trailContent boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.trailFont,NSForegroundColorAttributeName:self.trailColor} context:nil].size;
        self.trailLabel.center = CGPointMake(maxX + self.imageViewInset.right + trailSize.width * 0.5, self.frame.size.height * 0.5);
        self.trailLabel.bounds = CGRectMake(0, 0, trailSize.width, trailSize.height);
    }
}
//从右边向左边
- (void)layoutSubviewsFromTrail {
    CGFloat minX = self.frame.size.width - self.textInset.right;
    if (self.trailContent || self.trailContent.length > 0) {
        CGSize trailSize = [self.trailContent boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.trailFont,NSForegroundColorAttributeName:self.trailColor} context:nil].size;
        self.trailLabel.center = CGPointMake(minX - trailSize.width * 0.5, self.frame.size.height * 0.5);
        self.trailLabel.bounds = CGRectMake(0, 0, trailSize.width, trailSize.height);
        minX = CGRectGetMinX(self.frontLabel.frame);
    }
    
    if (self.imageName && self.imageName.length > 0) {
        self.middleImageView.center = CGPointMake(minX - self.imageViewInset.right - (self.frame.size.height - self.imageViewInset.top - self.imageViewInset.left) * 0.5, self.frame.size.height * 0.5);
        self.middleImageView.bounds = CGRectMake(0, 0, self.frame.size.height - self.imageViewInset.top - self.imageViewInset.left, self.frame.size.height - self.imageViewInset.top - self.imageViewInset.left);
        minX = CGRectGetMinX(self.middleImageView.frame);
    }
    
    if (self.frontContent || self.frontContent.length > 0) {
        CGSize frontSize = [self.frontContent boundingRectWithSize:self.bounds.size options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.frontFont,NSForegroundColorAttributeName:self.frontColor} context:nil].size;
        self.trailLabel.center = CGPointMake(minX - self.imageViewInset.left - frontSize.width * 0.5, self.frame.size.height * 0.5);
        self.trailLabel.bounds = CGRectMake(0, 0, frontSize.width, frontSize.height);
    }

}

@end
