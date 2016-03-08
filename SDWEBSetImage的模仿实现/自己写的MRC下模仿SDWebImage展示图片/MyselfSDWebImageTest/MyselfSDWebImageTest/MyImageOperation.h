//
//  MyImageOperation.h
//  MyselfSDWebImageTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSString+More.h"
@interface MyImageOperation : NSOperation
@property (nonatomic,copy)NSString *urlString;
@property(nonatomic,retain)UIImageView *imageView;
-(id)initWithUrl:(NSString *)urlString imageView:(UIImageView *)image;
-(NSData *)findFileFromMerory:(NSString *)fileName;
@end
