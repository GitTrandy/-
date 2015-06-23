//
//  DownLoadImage.h
//  iBranch
//
//  Created by jian jiao on 14-8-28.
//
//

#import <Foundation/Foundation.h>
typedef void(^CompleteBlock_t1)(NSData *data);
typedef void(^ErrorBlock_t1)(NSError *error);
@interface DownLoadImage : NSURLConnection<NSURLConnectionDataDelegate>
{
    NSMutableData *data_;
    CompleteBlock_t1 completeBlock_1;
    ErrorBlock_t1 errorBlock_1;
}

+ (id)request:(NSString *)requestUrl completeBlock:(CompleteBlock_t1)compleBlock errorBlock:(ErrorBlock_t1)errorBlock;

- (id)initWithRequest:(NSString *)requestUrl completeBlock:(CompleteBlock_t1)compleBlock errorBlock:(ErrorBlock_t1)errorBlock;
@end
