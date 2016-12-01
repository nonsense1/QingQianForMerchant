//
//  QQFMNetClient.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/21.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "QQFMNetClient.h"

@implementation QQFMNetClient

+(QQFMNetClient *)sharedClient{
    static QQFMNetClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    return client;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)requestWithURLString:(NSString *)URLString parameters:(id)paramters type:(HttpRequestType)type success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    return [self requestWithURLString:URLString parameters:paramters type:HttpRequestTypeGet progress:nil success:success failure:failure];
}

- (void)requestWithURLString:(NSString *)URLString parameters:(id)paramters type:(HttpRequestType)type progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(id _Nullable))success failure:(void (^)(NSError * _Nonnull))failure {
    NSString *URLPath = [NSString stringWithFormat:@"http://test.qingqian365.com%@",URLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    switch (type) {
        case HttpRequestTypeGet:
        {
            [manager GET:URLPath parameters:paramters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [manager POST:URLPath parameters:paramters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
        default:
            break;
    }
}

@end
