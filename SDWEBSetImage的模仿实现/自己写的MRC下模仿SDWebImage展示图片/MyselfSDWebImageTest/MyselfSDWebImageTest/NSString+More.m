//
//  NSString+More.m
//  MyselfSDWebImageTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NSString+More.h"

@implementation NSString (More)
-(void)dealloc
{
    [super dealloc];
}
+(NSString *)getFilePath:(NSString *)fileName
{
   
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:[NSString stringWithFormat:@"/caches/%@",[fileName base64EncodedString]]];
}
+(NSString *)filePath
{
    //获取文件夹名
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"caches"];
    
}
+(NSString *)saveToPath:(NSString *)fileName{
    NSFileManager *file=[NSFileManager defaultManager];
    if (![file fileExistsAtPath:[self filePath]]) {
        //创建文件夹
        [file createDirectoryAtPath:[self filePath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [self getFilePath:fileName];
}
@end
