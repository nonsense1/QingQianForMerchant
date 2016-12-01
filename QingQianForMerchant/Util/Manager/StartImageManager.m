//
//  StartImageManager.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "StartImageManager.h"

@interface StartImageManager ()

@property (nonatomic,strong) StartImage *startImage;

@end

@implementation StartImageManager

+ (instancetype)shareManager {
    static StartImageManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self createFolder:[self downloadPath]];
    }
    return self;
}

- (BOOL)createFolder:(NSString *)path {
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    BOOL isCreated = NO;
    if (!(isDir == YES && existed == YES)) {
        isCreated = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        isCreated = YES;
    }
    if (isCreated) {
        
    }
    return isCreated;
}

- (NSString *)downloadPath {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *downloadPath = [documentPath stringByAppendingString:@"QingQian_StartImages"];
    return downloadPath;
}

- (StartImage *)randomImage {
    return _startImage;
}

- (StartImage *)curIamge {
    if (!_startImage) {
        _startImage = [StartImage defaultImage];
    }
    return _startImage;
}


@end

@implementation StartImage

+ (StartImage *)defaultImage {
    StartImage *st = [[StartImage alloc] init];
    return st;
}

- (UIImage *)image {
    return [UIImage imageWithContentsOfFile:self.pathDisk];
}

@end

@implementation Group



@end
