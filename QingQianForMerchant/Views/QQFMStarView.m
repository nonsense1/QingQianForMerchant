//
//  QQFMStarView.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/24.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//
#define DEFAULT_TOTAL_STAR 5
#define DEFAULT_TOTAL_POINT 100
#define FOREGROUND_STAR_IMAGE_NAME @"StarView_ForeStar"
#define BACKGROUND_STAR_IMAGE_NAME @"StarView_BackStar"

#import "QQFMStarView.h"

@interface QQFMStarView ()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;
@property (nonatomic, assign) NSInteger totalStar;
@property (nonatomic, assign) CGFloat totalPoint;

@end

@implementation QQFMStarView



- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame withTotalStar:DEFAULT_TOTAL_STAR totalPoint:DEFAULT_TOTAL_POINT];
}

- (instancetype)initWithFrame:(CGRect)frame withTotalStar:(NSInteger)totalStar totalPoint:(CGFloat)totalPoint {
    
    if (self = [super initWithFrame:frame]) {
        _totalStar = totalStar;
        _totalPoint = totalPoint;
        [self configView];
    }
    
    return self;
}
#pragma mark - Private Methods
- (void)configView {
    _commentPoint = _totalPoint;
    
    self.foregroundStarView = [self createStartViewWithImage:FOREGROUND_STAR_IMAGE_NAME];
    self.backgroundStarView = [self createStartViewWithImage:BACKGROUND_STAR_IMAGE_NAME];
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
}

- (UIView *)createStartViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i= 0; i < self.totalStar; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width /self.totalStar, 0, self.bounds.size.width / self.totalStar, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews {
    self.foregroundStarView.frame = CGRectMake(0, 0, self.bounds.size.width * _commentPoint/_totalPoint, self.bounds.size.height);
}

- (void)setCommentPoint:(CGFloat)commentPoint {
    if (commentPoint == _commentPoint) {
        return;
    }
    if (_commentPoint < 0) {
        _commentPoint = 0;
    }else if (_commentPoint/_totalPoint > 1) {
        _commentPoint = _totalPoint;
    }else{
        _commentPoint = commentPoint;
    }
    [self setNeedsLayout];
}


@end
