//
//  UIImageView+More.m
//  MyselfSDWebImageTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "UIImageView+More.h"

@implementation UIImageView (More)
-(void)dealloc
{
    [super dealloc];
}
-(void)setImageWithUrl:(NSString *)urlString defaultImage:(UIImage *)image
{
    if (urlString==nil) {
        self.image=image;
    }else
    {
    
        [self useUrlGetImage:urlString defaultImage:image];
    }
    
}
-(void)useUrlGetImage:(NSString *)urlString defaultImage:(UIImage *)image
{
    MyImageManager *manager=[MyImageManager defaultImageManager];
    NSData *data1= [manager getSometingFromDicWithUrl:urlString];

   NSData *data2= [manager findFileFromMerory:urlString];
    
    if (data1!=nil) {
        self.image=[UIImage imageWithData:data1];
        return;
    }
    if (data2!=nil) {
        NSLog(@"在内存中加载图片");
        self.image=[UIImage imageWithData:data2];
        [manager.cacheDic setObject:data2 forKey:urlString];//存入缓存字典
        return;
    }
//    NSString *pa=[manager getPathOfImage:urlString];
//     NSData *da=[[NSData alloc]initWithContentsOfFile:pa];
//    if (da!=nil) {
//
//       
//        self.image=[UIImage imageWithData:da];
//        return;
//    }
    [manager downloadImageWithUrlString:urlString imageView:self];
}
@end
