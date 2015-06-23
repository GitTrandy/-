//
//  DownLoadImage.m
//  iBranch
//
//  Created by jian jiao on 14-8-28.
//
//

#import "DownLoadImage.h"
#import "MBProgressHUD.h"
@implementation DownLoadImage
+ (id)request:(NSString *)requestUrl completeBlock:(CompleteBlock_t1)compleBlock errorBlock:(ErrorBlock_t1)errorBlock;
{
   
    return [[self alloc] initWithRequest:requestUrl completeBlock:compleBlock errorBlock:errorBlock];
}

- (id)initWithRequest:(NSString *)requestUrl completeBlock:(CompleteBlock_t1)compleBlock errorBlock:(ErrorBlock_t1)errorBlock
{
    NSURL *url = [NSURL URLWithString:requestUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    if (self = [super initWithRequest:request delegate:self startImmediately:NO]) {
        data_ = [[NSMutableData alloc] init];
        
        completeBlock_1 = [compleBlock copy];
        errorBlock_1 = [errorBlock copy];
        
        [self start];
    }
    
    return self;
}

#pragma mark- NSURLConnectionDataDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [data_ setLength:0];
//   NSDictionary*dic= [response allHeaderFields];
    
  //  NSLog(@"dict is %@",dic);
    
    //NSString *ContentLength = dic[@"Content-Length"];
  //  NSLog(@"Content-Length is %@",ContentLength);
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [data_ appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    completeBlock_1(data_);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"下载失败请重新下载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    errorBlock_1(error);
}
@end
