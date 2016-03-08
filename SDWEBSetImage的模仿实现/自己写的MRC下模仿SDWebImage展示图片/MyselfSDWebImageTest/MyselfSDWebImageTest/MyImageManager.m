//
//  MyImageManager.m
//  MyselfSDWebImageTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MyImageManager.h"
#import "NSString+More.h"

static MyImageManager *manager;
@implementation MyImageManager
-(void)dealloc
{
    [super dealloc];
    [_cacheDic release];
//    [manager release];静态的不用释放。它存在堆上
    [[NSNotificationCenter defaultCenter]removeObserver:self];//通知释放
}
+(id)alloc
{
    @synchronized(self) {
        if (manager==nil) {
            manager=[[super alloc]init];
        }
    }
    return manager;
}
-(id)init
{
        if (self==[super init]) {
            //
            _cacheDic=[[NSMutableDictionary alloc]init];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(celearDic) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        }
    return self;
}
+(id)defaultImageManager
{
    @synchronized(self) {
        if (manager==nil) {
            manager=[[MyImageManager alloc]init];
        }
    }
    return manager;
}
-(void)celearDic
{
    [_cacheDic removeAllObjects];
}
//缓存
-(NSData *)getSometingFromDicWithUrl:(NSString *)urlString
{
    return [self.cacheDic objectForKey:urlString];
}
//内存
-(NSData *)findFileFromMerory:(NSString *)fileName
{
    NSData *data=[NSData dataWithContentsOfFile:[NSString getFilePath:fileName]];
    return data;
}
//内存
-(NSString *)getPathOfImage:(NSString *)urlString
{
    return [NSString getFilePath:urlString];
}



//下载
-(void)downloadImageWithUrlString:(NSString *)urlString imageView:(UIImageView *)imageView{

    MyImageOperation *oper=[[MyImageOperation alloc]initWithUrl:urlString imageView:imageView];
    NSOperationQueue *que=[[NSOperationQueue alloc]init];
    [que addOperation:oper];
    [oper release];
    [que release];

}
@end
