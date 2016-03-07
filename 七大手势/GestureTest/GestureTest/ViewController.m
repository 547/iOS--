//
//  ViewController.m
//  GestureTest
//
//  Created by mac on 16-1-20.
//  Copyright (c) 2016年 SevenDream. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
{
    UIImageView *imageView;
    UITextField *textField;
}
@end

@implementation ViewController
-(void)dealloc
{
    [textField release];
    textField=nil;
    [imageView release];
    imageView=nil;
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, 200, 100, 44)];
     button.backgroundColor=[UIColor redColor];
     [button setTitle:@"4555" forState:UIControlStateNormal];
     [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
     //removeTarget==移除指定的方法==
     [button removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:button];
     */

	// Do any additional setup after loading the view, typically from a nib.
    /*
     UIGestureRecognizer==继承与NSobject
     系统手势(Gesture)识别(Recognizer)
     以下这些都是UIGestureRecognizer的子类
     UITapGestureRecognizer===Tap(点击)
     UIPinchGestureRecognizer===Pinch(捏合)
     UIRotationGestureRecognizer===Rotation(旋转)
     UISwipeGestureRecognizer===Swipe(滑动,轻扫,快速移动,适用于监测滑动的方向的)
     UIPanGestureRecognizer===Pan(拖移,拖拽,慢速移动,是用于监测偏移量的)
     UIScreenEdgePanGestureRecognizer===ScreenEdgePan(屏幕侧边拖拽)
     UILongPressGestureRecognizer===LongPress(长按)
     */
    [self setPageView];
    //点击手势
    [self tapGesture];
    //捏合手势
    [self pinchGesture];
    //旋转手势
    [self rotationGestrue];
    //滑动,轻扫手势
    [self swipeGesture];
    //拖拽手势
    [self panGesture];
    //长按
    [self LongPress];
    //屏幕侧边拖拽
    [self screenEdgePan];
    
}
-(void)setPageView
{
    imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"奶沙紫薯果.jpg"]];
    imageView.center=self.view.center;
    imageView.bounds=CGRectMake(0, 0, 307, 367.5);
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 20, 200, 44)];
    textField.backgroundColor=[UIColor redColor];
//    textField.center=CGPointMake(self.view.center.x, 30);
//    textField.bounds=CGRectMake(0, 0, self.view.frame.size.width*(2/3), 44);
    textField.text=@"复制";
    [self.view addSubview:textField];
    
}

//点击手势
-(void)tapGesture
{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    //设置点击次数或获取点击次数==默认为1==通过设置这个实现单击\双击\...设置numberOfTapsRequired=2就是双击
    tap.numberOfTapsRequired=2;
    //设置点击的手指的数量或获取点击的手指数量==默认为1
    tap.numberOfTouchesRequired=1;
    //tap.numberOfTouches==本地可以找寻到的点击次数
    [tap addTarget:self action:@selector(tapAdd:)];
    
    /**
     removeTarget==移除方法指定的方法
     action=填的参数如果是nil,就移除该控件绑定的所有的方法
     **/
    //    [tap removeTarget:self action:nil];
    //一定要将手势识别器加在View上,不然不会响应
    [self.view addGestureRecognizer:tap];
    [tap release];
}
//捏合手势
-(void)pinchGesture
{
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGesture:)];
    [imageView addGestureRecognizer:pinch];
    [pinch release];
}
//旋转手势
-(void)rotationGestrue
{
    UIRotationGestureRecognizer *rotationGesture=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGesture:)];
    [imageView addGestureRecognizer:rotationGesture];
    [rotationGesture release];
}
//滑动,轻扫手势
-(void)swipeGesture
{
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipGesture:)];
    //设置参与轻扫\滑动的手指的个数
    swipe.numberOfTouchesRequired=1;
    /**
     目前系统不支持向上和向下滑动
     滑动的方向direction
     NS_OPTIONS===多选值
     typedef NS_OPTIONS(NSUInteger, UISwipeGestureRecognizerDirection) {
     UISwipeGestureRecognizerDirectionRight = 1 << 0,默认向右
     UISwipeGestureRecognizerDirectionLeft  = 1 << 1,向左
     UISwipeGestureRecognizerDirectionUp    = 1 << 2,向上
     UISwipeGestureRecognizerDirectionDown  = 1 << 3向下
     };
     **/
    swipe.direction=UISwipeGestureRecognizerDirectionRight|UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionDown;
    [imageView addGestureRecognizer:swipe];
    [swipe release];
}
//拖拽手势
-(void)panGesture
{
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [imageView addGestureRecognizer:pan];
    [pan release];
}
//屏幕侧边拖拽
-(void)screenEdgePan
{
    //UIScreenEdgePanGestureRecognizer继承于UIPanGestureRecognizer
    UIScreenEdgePanGestureRecognizer *screenEdgePan=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdgePanGesture:)];
    /**
     唯一的一个属性
     typedef NS_OPTIONS(NSUInteger, UIRectEdge) {
     UIRectEdgeNone   = 0,
     UIRectEdgeTop    = 1 << 0,
     UIRectEdgeLeft   = 1 << 1,
     UIRectEdgeBottom = 1 << 2,
     UIRectEdgeRight  = 1 << 3,
     UIRectEdgeAll    = UIRectEdgeTop | UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight
     } NS_ENUM_AVAILABLE_IOS(7_0);
     **/
    screenEdgePan.edges=UIRectEdgeAll;
    [self.view addGestureRecognizer:screenEdgePan];
    [screenEdgePan release];
}
//长按
-(void)LongPress
{
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    //设置长按时需要按压的手指数
    longPress.numberOfTouchesRequired=1;
    //设置代替长按的点击的次数=longPress.numberOfTapsRequired=2;=就是点两次相当于长按==默认为0
    longPress.numberOfTapsRequired=0;
    //设置最短长按时间==默认为0.5s
    longPress.minimumPressDuration=0.1;
    //设置长按时允许移动的最大的像素
//    longPress.allowableMovement
    [textField addGestureRecognizer:longPress];
    [longPress release];
}
#pragma mark===Tap的方法
-(void)tapAdd:(UITapGestureRecognizer *)tap
{
    NSLog(@"4545====TouchesRequired=%d=touches=%d==TapsRequired=%d",tap.numberOfTouchesRequired,tap.numberOfTouches,tap.numberOfTapsRequired);
    //locationOfTouch获取点击的坐标
    CGPoint point = [tap locationOfTouch:tap.numberOfTouches-1 inView:self.view];
    NSLog(@"====%@",NSStringFromCGPoint(point));

}
-(void)tap
{
    NSLog(@"TAP===%s",__FUNCTION__);
}
#pragma mark==Pinch的方法
-(void)pinchGesture:(UIPinchGestureRecognizer *)pinch
{
//    NSLog(@"-----pinch--%s",__FUNCTION__);
    /**
     velocity===velocity of the pinch in scale/second
     每秒捏合比例变化的速率
     **/
//    NSLog(@"-----pinch-速率-%f",pinch.velocity);
    /**
     scale==捏合的比例变化===手势往里捏scale就变小===往外scale就变大
     View==添加该手势的视图
     **/
//    NSLog(@"======pinchscale==%f==",pinch.scale);
    //图片根据手势的捏合放大缩小
    CGFloat arriswise=sqrtf(pinch.view.frame.size.width*pinch.view.frame.size.width+pinch.view.frame.size.height*pinch.view.frame.size.height);
    CGFloat screenArriswise=sqrtf(self.view.frame.size.width*self.view.frame.size.width+self.view.frame.size.height*self.view.frame.size.height);
    if (arriswise>100 && arriswise<screenArriswise) {
            pinch.view.bounds=CGRectMake(0, 0, pinch.view.frame.size.width*pinch.scale, pinch.view.frame.size.height*pinch.scale);
        NSLog(@"+++++arriswise>100 && arriswise<screenArriswise");
    }else if ((arriswise<=100 && pinch.scale>1.0) || (arriswise>=screenArriswise && pinch.scale<1.0)) {
        pinch.view.bounds=CGRectMake(0, 0, pinch.view.frame.size.width*pinch.scale, pinch.view.frame.size.height*pinch.scale);
        NSLog(@">>>>...else if");
    }
}
#pragma mark===rotation的方法
-(void)rotationGesture:(UIRotationGestureRecognizer *)rotation
{
//    NSLog(@"rotation==%s",__FUNCTION__);
    //rotation==旋转的角度===顺时针转动就加>0,逆时针转动就减<0
//    NSLog(@"rotation角度==%f",rotation.rotation);
    //velocity of the pinch in radians/second==旋转的速率
//    NSLog(@"旋转的速率===%f",rotation.velocity);
    //transform==让添加了旋转手势的View根据旋转的角度旋转相应的角度
    rotation.view.transform = CGAffineTransformMakeRotation(rotation.rotation);
}
#pragma mark===swipe的方法
-(void)swipGesture:(UISwipeGestureRecognizer *)swipe
{
    NSLog(@"swipe===%s",__FUNCTION__);
    NSLog(@"滑动的方向====%d",swipe.direction);
    NSLog(@"开始==%d",swipe.state);
}
#pragma mark===Pan的方法
-(void)panGesture:(UIPanGestureRecognizer *)pan
{
    NSLog(@"pan===%s",__FUNCTION__);
     }
#pragma mark===LongPress的方法
-(void)longPress:(UILongPressGestureRecognizer *)longPress
{
    NSLog(@"longPress-----%s",__FUNCTION__);
    //UIMenuController是一个单例类
    UIMenuItem *itemCopy=[[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyOrPaste:)];
    UIMenuItem *itemPaste=[[UIMenuItem alloc]initWithTitle:@"粘贴" action:@selector(copyOrPaste:)];
    UIMenuController *menu=[UIMenuController sharedMenuController];
    menu.menuItems=@[itemCopy,itemPaste];
    CGPoint point=[longPress locationInView:self.view];
    [menu setTargetRect:CGRectMake(point.x, point.y, 0, 0) inView:self.view];
//menu.menuFrame=CGRectMake(point.x, point.y,, <#CGFloat height#>)
    [menu setMenuVisible:YES animated:YES];
}
-(void)copyOrPaste:(UIMenuItem *)item
{
//    NSLog(@"%@",item.title);
    NSLog(@"455454545ppp");
}
//UIMenuController必须重写父类下面的方法,并返回YES
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
#pragma mark===ScreenEdgePan的方法
-(void)screenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)screenEdgePan
{
    NSLog(@"ScreenEdgePan");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
