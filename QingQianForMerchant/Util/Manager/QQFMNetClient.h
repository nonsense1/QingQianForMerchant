//
//  QQFMNetClient.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/21.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,HttpRequestType) {
    HttpRequestTypeGet = 0,
    HttpRequestTypePost,
};


NS_ASSUME_NONNULL_BEGIN

@interface QQFMNetClient : NSObject

+ (nonnull QQFMNetClient *)sharedClient;

- (void)requestWithURLString:(NSString *)URLString
                  parameters:(nullable id)paramters
                        type:(HttpRequestType)type
                     success:(nullable void (^) (id _Nullable responseObject))success
                     failure:(nullable void(^)(NSError *error))failure;

- (void)requestWithURLString:(NSString *)URLString
                  parameters:(nullable id)paramters
                        type:(HttpRequestType)type
                    progress:(nullable void (^) (NSProgress * downloadProgress))downloadProgress
                     success:(nullable void (^)(id _Nullable responseObject))success
                     failure:(nullable void (^)(NSError *error))failure;

@end
NS_ASSUME_NONNULL_END
