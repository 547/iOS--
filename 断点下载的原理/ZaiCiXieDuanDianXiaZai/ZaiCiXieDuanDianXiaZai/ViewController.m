//
//  ViewController.m
//  ZaiCiXieDuanDianXiaZai
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURLConnection *connection;
    NSMutableData *_dataBuffer;
    NSFileHandle *fileHandle;
    long long receivedData;//目前已经接受到的数据，即已经存储的数据
    long long totalData;//目前要下载的文件的总大小
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.downProgress setProgress:0];
    self.progressLabel.text=@"";
}
- (IBAction)cancel:(UIButton *)sender {
    [connection cancel];
    NSLog(@"取消下载");
}

- (IBAction)downLoad:(UIButton *)sender {
    //http://localhost:8080/MyDownLoad/13.1点菜资源.zip
    //获取当前文件下载了多少
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSDictionary *dic= [fileManager attributesOfItemAtPath:[self getFilePath:@"netbeans.dmg.zip"] error:nil];
    NSNumber *number= [dic objectForKey:NSFileSize];
    receivedData=[number longLongValue];
    //下载地址
    NSString *urlString=@"http://localhost:8080/MyDownLoad/netbeans.dmg.zip";
    //如果url中有中文就要经过这个方法进行编码
   urlString= [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //创建一个可变请求
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    //设置请求超时时间
    [request setTimeoutInterval:30];
    //设置请求方式
    [request setHTTPMethod:@"Post"];
    //这句话必须写==是断点续存的关键==就是告诉服务器当前客户端已经存储到数据的某一阶段了，服务器只要返回该阶段后面的数据就行了，不需要从头开始返回===Range关键字就是可以告诉服务器当前客户端目前的存储进度
    [request addValue:[NSString stringWithFormat:@"bytes-%lld-",receivedData] forHTTPHeaderField:@"Range"];
    //初始化与服务器的连接
    connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error===%@",error);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    _dataBuffer=[[NSMutableData alloc]init];
    //获得要下载的文件的总大小===[response expectedContentLength] 服务器即将要返回的剩下数据的大小+已经保存的数据大小
    totalData=receivedData+[response expectedContentLength];
    //句柄在使用的时候必须要准备一个真实存在的路径文件来初始化[原理就是句柄会追加数据到文件的末尾]
    fileHandle=[NSFileHandle fileHandleForWritingAtPath:[self getARealFilePath]];
}
//这个方法是每时每刻都会调用的，只要服务器在返回数据给客户端
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//    [_dataBuffer appendData:data];
//    NSLog(@" 已下载=%ld",_dataBuffer.length);
    //找到句柄中保存的文件文件的尾部
    [fileHandle seekToEndOfFile];
    //写入后续数据===在末尾追加从服务器传递过来的数据
    [fileHandle writeData:data];
    //实时获取当前已经下载的数据大小
    receivedData=receivedData+data.length;
//     NSLog(@"%lld",receivedData);
    //一定要记得强转一下，receivedData和totalData都是整形
    CGFloat progress=(float)receivedData/totalData;
    NSLog(@"当前进度==%f",progress);
    [self.downProgress setProgress:progress animated:YES];
    NSString *str=@"%";
    self.progressLabel.text=[NSString stringWithFormat:@"%0.2f%@",progress*100,str];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    [_dataBuffer writeToFile:[self getFilePath:@"13.1点菜资源.zip"] atomically:YES];
    //关闭fileHandle
    [fileHandle closeFile];
    NSLog(@"下载结束");
}
-(NSString *)getFilePath:(NSString *)fileName
{
   return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:fileName];
}
-(NSString *)getARealFilePath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[self getFilePath:@"netbeans.dmg.zip"]])
    {
        [fileManager createFileAtPath:[self getFilePath:@"netbeans.dmg.zip"] contents:nil attributes:nil];
    }
    return [self getFilePath:@"netbeans.dmg.zip"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
