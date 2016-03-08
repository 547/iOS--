//
//  MyImageOperation.m
//  MyselfSDWebImageTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MyImageOperation.h"
#import "MyImageManager.h"
#import "Base64.h"
@implementation MyImageOperation

-(void)dealloc
{
    [super dealloc];
    [_urlString release];
    [_imageView release];
}
-(id)initWithUrl:(NSString *)urlString imageView:(UIImageView *)image
{
    if (self==[super init]) {
        self.urlString=urlString;
        self.imageView=image;
    }
    return self;
}
-(void)main
{
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]];
    UIImage *image=[UIImage imageWithData:data];
    if (data!=nil) {
        [self performSelectorOnMainThread:@selector(updataUI:) withObject:image waitUntilDone:YES];
        MyImageManager *manager=[MyImageManager defaultImageManager];
        [manager.cacheDic setObject:data forKey:self.urlString];//缓存
//        NSLog(@"%@",[NSString saveToPath:[self.urlString base64EncodedString]]);
        [data writeToFile:[NSString saveToPath:self.urlString] atomically:YES];//保存到本地

        
    }

}
-(void)updataUI:(UIImage *)image
{
    self.imageView.image=image;
}
@end
