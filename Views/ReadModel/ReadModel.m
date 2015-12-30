//
//  ReadModel.m
//  aishengHuo
//
//  Created by qianfeng on 15/12/30.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ReadModel.h"

@implementation ReadModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.dataID = value;
    }
}


@end
