//
//  SKXMLParser.m
//  SimpleKit
//
//  Created by SimpleKit on 13-1-21.
//  Copyright (c) 2013年 SimpleKit. All rights reserved.
//

#import "SKXMLParser.h"

@interface SKXMLParser () <NSXMLParserDelegate>

@property (nonatomic, retain) NSMutableDictionary *resultDic;
@property (nonatomic, copy) NSString *tempValue;
@property (nonatomic, retain) NSMutableDictionary *tempDict;
@property (nonatomic, retain) NSMutableArray *elementStack; // element name stack
@property (nonatomic, retain) NSMutableArray *dictStack; // element dictionary stack
@property (nonatomic, copy) NSString *lastElementName;
@property (nonatomic, assign) BOOL parseXML; // 为了能处理制定rootNodeName来解析，引入这个变量来做判断处理
@property (nonatomic, assign) BOOL isElementReturnNull; // 当节点元素返回为空的时候<element></element>，NSXMLParser不会调用foundCharacters，导致_tempValue的值不会改变，而实际上应该为空字符，为了处理这个逻辑，特引入这个变量

@end

@implementation SKXMLParser
{}
#pragma mark -
#pragma mark Super Methods
- (void)dealloc {
    // TODO: Release code
    [_resultDic release];
    [_tempValue release];
    [_tempDict release];
    [_elementStack release];
    [_dictStack release];
    [_lastElementName release];
    [_rootNodeName release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.resultDic = [NSMutableDictionary dictionaryWithCapacity:0];
        self.elementStack = [NSMutableArray arrayWithCapacity:0];
        self.dictStack = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

#pragma mark -
#pragma mark Public Methods
- (NSDictionary *)dictionaryWithXMLData:(NSData *)data {
    self.parseXML = NO;
    NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:data] autorelease];
    [parser setDelegate:self];
    [parser parse]; // 通过验证得知：此方法能够保持线程一直运行，而不会先跳过此处继续执行后面的语句，貌似已经block了当前线程，所以可以将解析结果作为成员变量在下面的return 中返回。
//    SKLog(@">>> dictionaryWithXMLData");
    return _resultDic;
}

#pragma mark -
#pragma mark Delegate Methods
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
//    NSLog(@"didStartElement elementName, namespaceURI, qName, attributeDict: %@, %@, %@, %@", elementName, namespaceURI, qName, attributeDict);
    
    /*
     数据结构如下：
     
     字典 {
            key-标签名称 = {
                key-attribute = {
     
                };
                value-字典或者文本
            };
     
            key-标签名称 = {
                key-attribute = {
     
                };
                value-字典或者文本 {
                    key-二级标签名称 = {
                        key-attribute = {
     
                        };
                        value-字典或者文本
                    }
                }
            };
     }
     */
    
    if (_rootNodeName == nil || [elementName isEqualToString:_rootNodeName]) {
        self.parseXML = YES;
    }
    
    if (_parseXML) {
        
        self.isElementReturnNull = YES;
        
        [_elementStack addObject:elementName];
        
        NSMutableDictionary *elementDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [_dictStack addObject:elementDic];
        
        // 具体元素的值的字典
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic setObject:attributeDict forKey:@"attribute"];
        [dic setObject:[NSMutableDictionary dictionaryWithCapacity:0] forKey:@"value"];
        [elementDic setObject:dic forKey:elementName];
        
        self.tempDict = dic;
        self.lastElementName = elementName;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//    NSLog(@"didEndElement elementName, namespaceURI, qName, attributeDict: %@, %@, %@", elementName, namespaceURI, qName);
    
    if (!_parseXML) {
        return;
    }
    
    if (_isElementReturnNull == YES) {
        self.tempValue = @"";
    }
    
    // 表示最底层节点字典的字典 -- _tempDict（有两个key：attribute 和 value，其中value对应的值为字符值）
    if ([_lastElementName isEqualToString:elementName]) {
        [_tempDict setObject:_tempValue forKey:@"value"];
    }
    
    // 思路：在每层结束标签的地方，将此层的数据加到上层数据的数组中去
    
    // 本层的上一层标签的字典数据
    NSInteger index = [_elementStack indexOfObject:elementName] - 1;
    if (index >= 0 && [_elementStack indexOfObject:elementName] != NSNotFound) {
        
//        NSLog(@">>> max int: %d; %d", INT_MAX, [_elementStack indexOfObject:elementName]);
        
        // 上层节点的字典（key为elementName）
        NSMutableDictionary *elementDic = [_dictStack objectAtIndex:[_elementStack indexOfObject:elementName] - 1];
        NSString *superElementName = [_elementStack objectAtIndex:index];
        // 上层节点中字典的字典（有两个key：attribute 和 value，其中value对应的值可能为字符值或者字典）
        NSMutableDictionary *superElementDic = [elementDic objectForKey:superElementName];
        NSMutableDictionary *vauleDic = [superElementDic objectForKey:@"value"];
        
        // 当前节点的字典
        NSMutableDictionary *nodeDic = [_dictStack objectAtIndex:[_elementStack indexOfObject:elementName]];
//        NSLog(@"nodeDic: %@", nodeDic);
        
        
        // 表示最底层节点字典的字典 -- _tempDict（有两个key：attribute 和 value，其中value对应的值为字符值）
        if ([_lastElementName isEqualToString:elementName]) {
            // 如果vauleDic中已经有key为elementName，则需要将这个key对应的字典值改为数组值
            if ([[vauleDic allKeys] containsObject:elementName]) {
                if (![[vauleDic objectForKey:elementName] isKindOfClass:[NSMutableArray class]]) {
//                    SKLog(@"第一次不是数组");
                    
                    // 此dic有两个key：attribute 和 value，其中value对应的值为字符值，这是之前已经存入的字典数据
                    NSMutableDictionary *dic = [vauleDic objectForKey:elementName];
                    
                    // 之前存于字典中的数据要放到数组中
                    NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:0];
                    [valueArray addObject:dic];
                    
                    // 本节点字典的字典数据，有两个key：attribute 和 value，其中value对应的值为字符值
                    [valueArray addObject:_tempDict];
                    
                    // 将字典型数据改为数组型数据，因为有多个key相同
                    [vauleDic setObject:valueArray forKey:elementName];
                } else { // 已经将字典型数据改为数组型数据
                    NSMutableArray *valueArray = [vauleDic objectForKey:elementName];
                    [valueArray addObject:_tempDict];
                }
            } else { // 没有key重复的情况
                [vauleDic setObject:_tempDict forKey:elementName];
            }
        } else { // 不是最底层节点，并且出现多个key相同的情况
            // 如果vauleDic中已经有key为elementName，则需要将这个key对应的字典值改为数组值
            if ([[vauleDic allKeys] containsObject:elementName]) {
                if (![[vauleDic objectForKey:elementName] isKindOfClass:[NSMutableArray class]]) {
                    // 此dic有两个key：attribute 和 value，其中value对应的值为字符值或者字典值，这是之前已经存入的字典数据
                    NSMutableDictionary *dic = [vauleDic objectForKey:elementName];
                    
                    // 之前存于字典中的数据要放到数组中
                    NSMutableArray *valueArray = [NSMutableArray arrayWithCapacity:0];
                    [valueArray addObject:dic];
                    
                    // 本节点字典的字典数据，有两个key：attribute 和 value，其中value对应的值为字符值
                    NSMutableDictionary *thisDic = [nodeDic objectForKey:elementName];
                    [valueArray addObject:thisDic];
                    
                    // 将字典型数据改为数组型数据，因为有多个key相同
                    [vauleDic setObject:valueArray forKey:elementName];
                } else { // 已经将字典型数据改为数组型数据
                    // 本节点字典的字典数据，有两个key：attribute 和 value，其中value对应的值为字符值
                    NSMutableDictionary *thisDic = [nodeDic objectForKey:elementName];
                    
                    NSMutableArray *valueArray = [vauleDic objectForKey:elementName];
                    [valueArray addObject:thisDic];
                }
            } else { // 没有key重复的情况
                [superElementDic setObject:nodeDic forKey:@"value"];
            }
        }
        
//        [elementDic setObject:@"999" forKey:@"000"];
//        NSLog(@"elementDic: %@", elementDic);
//        NSLog(@">>>superElementName: %@", superElementName);
        self.resultDic = elementDic;
    }
    
    // 当前节点的字典
    NSMutableDictionary *nodeDic = nil;
    if ([_elementStack indexOfObject:elementName] != NSNotFound) {
        nodeDic = [_dictStack objectAtIndex:[_elementStack indexOfObject:elementName]];
    }
    
    if ([_elementStack containsObject:elementName]) {
        [_dictStack removeObjectAtIndex:[_elementStack indexOfObject:elementName]];
        [_elementStack removeObject:elementName];
    }
    
    // 特殊情况处理：处理只有根节点这么一级的特殊xml
    if (index < 0 && [_elementStack count] == 0) {
        self.resultDic = nodeDic;
    }
    
//    NSMutableArray *elementArray = [_dictStack objectAtIndex:[_elementStack indexOfObject:elementName]];
    // 具体元素的值的字典
//    NSLog(@"_tempValue: %@", _tempValue);
    
    
//    NSLog(@"_elementStack: %@", _elementStack);
//    NSLog(@"_dictStack: %@", _dictStack);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//    NSLog(@"foundCharacters: %@", string);
    self.tempValue = string;
    self.isElementReturnNull = NO;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
//    SKLog(@">>> parseErrorOccurred: %@", parseError);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
//    SKLog(@">>> parserDidEndDocument");
}

#pragma mark -
#pragma mark Private Methods
- (void)_initData {
	// TODO: init data code
}

@end
