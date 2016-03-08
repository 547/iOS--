//
//  ViewController.h
//  ZaiCiXieDuanDianXiaZai
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIProgressView *downProgress;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

- (IBAction)cancel:(UIButton *)sender;
- (IBAction)downLoad:(UIButton *)sender;


@end

