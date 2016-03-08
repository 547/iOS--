//
//  MyImageManager.h
//  MyselfSDWebImageTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MyImageOperation.h"
@interface MyImageManager : NSObject
@property(nonatomic,retain)NSMutableDictionary *cacheDic;
+(id)defaultImageManager;
-(NSString *)getPathOfImage:(NSString *)urlString;
-(void)downloadImageWithUrlString:(NSString *)urlString imageView:(UIImageView *)imageView;
-(NSData *)getSometingFromDicWithUrl:(NSString *)urlString;
-(UIImage *)findImageFromMerory:(NSString *)fileName;
-(NSData *)findFileFromMerory:(NSString *)fileName;
@end
