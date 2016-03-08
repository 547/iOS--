//
//  ViewController.m
//  MyselfSDWebImageTest
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
-(void)dealloc
{
    [super dealloc];
    [_myImageView release];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.myImageView setImageWithUrl:@"http://www.bz55.com/uploads/allimg/130803/1-130P3112Q0.jpg" defaultImage:[UIImage imageNamed:@"5.png"]];
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
