//
//  StartImageManager.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StartImage;
@class Group;


@interface StartImageManager : NSObject

+ (instancetype)shareManager;
- (StartImage *)randomImage;
- (StartImage *)curIamge;

@end

@interface StartImage : NSObject

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) Group *group;
@property (nonatomic,strong) NSString *fileName, *descriptionStr, *pathDisk;
+ (StartImage *)defaultImage;
- (UIImage *)image;
@end

@interface Group : NSObject
@property (nonatomic,strong) NSString *name, *author, *link;
@end
