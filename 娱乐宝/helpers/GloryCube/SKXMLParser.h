//
//  SKXMLParser.h
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013 SimpleKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKXMLParser : NSObject

@property (nonatomic, copy) NSString *rootNodeName;

- (NSDictionary *)dictionaryWithXMLData:(NSData *)data;

@end
