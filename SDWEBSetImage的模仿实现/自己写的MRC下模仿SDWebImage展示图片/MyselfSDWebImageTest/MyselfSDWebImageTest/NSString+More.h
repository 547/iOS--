//
//  NSString+More.h
//  MyselfSDWebImageTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Base64.h"
@interface NSString (More)
+(NSString *)getFilePath:(NSString *)fileName;
+(NSString *)saveToPath:(NSString *)fileName;
@end
