//
//  ViewController.m
//  2
//
//  Created by bytedance on 2020/7/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController ()

-(void)Calculation;
-(void)clear:(UIButton*)it;

@property(nonatomic,strong) UILabel *text;
@property(nonatomic,strong) NSString *ans;
@property(nonatomic,strong) NSString *secondNumber;

@property(nonatomic,assign) BOOL isAfterCalculate;
@property(nonatomic,assign) BOOL isInEqualCalculator;
@property(nonatomic,assign) int C;
@end

@implementation ViewController
-(BOOL)isZero:(double)x{
    static double eps =0.000001;
    return (x>-eps && x<eps);
}
-(void)Calculation{
    if(self.isAfterCalculate) return;
    double tmp = 0.0;
    double num1 = [self.ans doubleValue];
    double num2 = [self.secondNumber doubleValue];
    static long long inf = 100000000000000;
    switch (self.C){
        case 1:{
                tmp = num1 + num2;
                
                if(tmp >= inf){
                    self.text.text=@"Too big";
                    self.secondNumber = @"0";
                    self.ans = nil;
                    self.isAfterCalculate = NO;
                    return;
                }
        }
            break;
        case 2:{
                tmp = num1 - num2;
                
                if(tmp <= -inf){
                    self.text.text=@"Too small";
                    self.secondNumber = @"0";
                    self.ans = nil;
                    self.isAfterCalculate = NO;
                    return;
                }
        }
                break;
        case 3:{
                tmp = num1 * num2;
                
                if(tmp >= inf){
                    self.text.text=@"Too big";
                    self.secondNumber = @"0";
                    self.ans = nil;
                    self.isAfterCalculate = NO;
                    return;
                }
        }
                break;
        case 4:{
                    if([self isZero:num2]){
                    self.text.text=@"ERROR";
                    self.secondNumber = @"0";
                    self.ans = nil;
                    self.isAfterCalculate = NO;
                    return;
                }
                else
                    tmp = num1 / num2;
        }
                break;
        case 5:{
                    tmp = pow(num1, num2);
                    
                    if(tmp >= inf){
                        self.text.text=@"Too big";
                        self.secondNumber = @"0";
                        self.ans = nil;
                        self.isAfterCalculate = NO;
                        return;
                    }
        }
            break;
    }
    double num3 = tmp - (long long)tmp;
    
    self.ans = self.text.text = [self isZero:num3]?[NSString stringWithFormat:@"%.0lf",tmp]:[NSString stringWithFormat:@"%lf",tmp];

}
-(void)equal:(UIButton*)it{
    if(self.ans == nil) return;
        else [self Calculation];
    
    self.isInEqualCalculator = YES;
}
-(void)addCalc:(UIButton*)it{
    self.C = 1;
    
    if(self.isInEqualCalculator){
        self.ans = self.text.text;
        self.isInEqualCalculator = NO;
        self.isAfterCalculate = YES;
    }
    
     if(self.isAfterCalculate) return;
     
     if(self.ans != nil ) [self Calculation];
     else self.ans = self.text.text;
    
     self.isAfterCalculate = YES;
}
-(void)minusCalc:(UIButton*)it{
    self.C = 2;
     
     if(self.isInEqualCalculator){
         self.ans = self.text.text;
         self.isInEqualCalculator = NO;
         self.isAfterCalculate = YES;
     }
     
      if(self.isAfterCalculate) return;
      
      if(self.ans != nil ) [self Calculation];
       else self.ans = self.text.text;
      
       self.isAfterCalculate = YES;
}
-(void)multiplyCalc:(UIButton*)it{
   self.C = 3;
    
    if(self.isInEqualCalculator){
        self.ans = self.text.text;
        self.isInEqualCalculator = NO;
        self.isAfterCalculate = YES;
    }
    
     if(self.isAfterCalculate) return;
     
     self.isAfterCalculate = YES;
     
     if(self.ans != nil ) [self Calculation];
        else self.ans = self.text.text;
}
-(void)divideCalc:(UIButton*)it{
   self.C = 4;
    
    if(self.isInEqualCalculator){
        self.ans = self.text.text;
        self.isInEqualCalculator = NO;
        self.isAfterCalculate = YES;
    }
    
     if(self.isAfterCalculate) return;
     
     if(self.ans != nil ) [self Calculation];
      else self.ans = self.text.text;
     
      self.isAfterCalculate = YES;
}
-(void)squareCalc:(UIButton*)it{
    self.C = 5;
     
    if(self.isInEqualCalculator){
        self.ans = self.text.text;
        self.isInEqualCalculator = NO;
        self.isAfterCalculate = YES;
    }
    
     if(self.isAfterCalculate) return;
     
     if(self.ans != nil ) [self Calculation];
      else self.ans = self.text.text;
     
      self.isAfterCalculate = YES;
}
-(void)sqrtCalc:(UIButton*)it{
    if(self.ans == nil || self.isAfterCalculate ||self.isInEqualCalculator){
        double num = [self.text.text doubleValue];
        num = sqrt(num);
        double num3 = num - (long long)num;
        self.secondNumber = @"0";
        self.ans = self.text.text = [self isZero:num3]?[NSString stringWithFormat:@"%.0lf",num]:[NSString stringWithFormat:@"%lf",num];
    }
    else{
        double num = [self.secondNumber doubleValue];
            
        self.secondNumber = [NSString stringWithFormat:@"%lf",sqrt(num)];
            
        [self Calculation];
    }
    //self.ans = nil;
    self.isAfterCalculate = NO;
    self.isInEqualCalculator = YES;
}
-(void)addnum:(UIButton*)it{
    
    if(self.isAfterCalculate){
        [self clear:it];
        self.isAfterCalculate = NO;
    }
    
    if(self.isInEqualCalculator) [self allClear:it];
    
    if(self.text.text.length == 12) return;
    
    NSString* str = [it titleForState:UIControlStateNormal];
    long long temp = [self.text.text longLongValue];
    temp = temp * 10;
    self.text.text = [NSString stringWithFormat:@"%lld",temp+[str longLongValue]];
    self.secondNumber=self.text.text;
    //NSLog(@"%@",self.text.text);
}

-(void)backSpace:(UIButton*)it{
    if(self.isInEqualCalculator) return;
    if(self.text.text.length == 0) return;
    else if(self.text.text.length == 1) self.text.text=@"0";
    else
    self.text.text = [self.text.text substringToIndex:(self.text.text.length-1)];
}

-(void)allClear:(UIButton*)it{
    self.secondNumber=self.text.text=@"0";
    self.ans = nil;
    self.isAfterCalculate = NO;
    self.isInEqualCalculator = NO;
}

-(void)clear:(UIButton*)it{
    
    if(self.isInEqualCalculator) [self allClear: it];
    else
    self.secondNumber=self.text.text=@"0";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.view.backgroundColor = [UIColor purpleColor];
    
    
    UIView * nv= [[UIView alloc] initWithFrame:CGRectMake(15,30,345,175)];
    nv.layer.backgroundColor=[[[UIColor blackColor]colorWithAlphaComponent:0.01] CGColor];
    nv.layer.cornerRadius = 5;
    
    self.text = [ [UILabel alloc]initWithFrame:CGRectMake(15,30,345,175)];
    
    [self.view addSubview: nv];
    [nv addSubview:self.text];
    
    
    self.text.text = @"0" ;
    
    self.text.textColor = [UIColor blackColor];
    self.text.font = [UIFont systemFontOfSize:40];
    //text.backgroundColor = [UIColor redColor];
    //[self.text sizeToFit];
    
    int x=15,y=225,w=75,h=75;
    int cntx=0,cnty=0;
    NSString *temp = @"C741^<8520 963 /*-+=\0";
    
    for(int i = 0 ; i < 20 ; i++)
    {
        UIView * newView = [[UIView alloc] initWithFrame:CGRectMake(x+cntx*90, y+cnty*90, w, h)];
        //UILabel * newLable = [[UILabel alloc] initWithFrame:CGRectMake(32.5, 0, w, h)];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0, 0, w, h);
        newView.layer.borderWidth = 2;
        newView.layer.backgroundColor = [[[UIColor blackColor]colorWithAlphaComponent:0.3] CGColor];
        //newLable.textColor = [UIColor blackColor];
       // newLable.font = [UIFont systemFontOfSize:20];
        //2.5 消角
        newView.layer.cornerRadius = 20;
        //[newView.layer setMasksToBounds:YES];
        
        newView.backgroundColor = [UIColor whiteColor];
        //btn.backgroundColor = [UIColor redColor];
        //newLable.text = [temp substringWithRange:NSMakeRange(i, 1)];
        [btn setTitle:[temp substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateNormal];
        [btn setTitle:[temp substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        newView.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.1];
        //2.4 tag值
        newView.tag = 101 + cntx*3 + cnty;//一般tag值在100以上比较好, 避免出现冲突
        btn.tag = 201 + cntx*3 + cnty;
        //C741^<8520%963 /*-+=\0
        switch (i) {
            case 0:{
                [btn setTitle:@"CE" forState:UIControlStateNormal];
                [btn setTitle:@"CE" forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(allClear:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 4:
                [btn addTarget:self action:@selector(squareCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 5:
                [btn addTarget:self action:@selector(backSpace:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 10:{
                [btn setTitle:@"C" forState:UIControlStateNormal];
                [btn setTitle:@"C" forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 14:{
                [btn setTitle:@"√" forState:UIControlStateNormal];
                [btn setTitle:@"√" forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(sqrtCalc:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 15:
                [btn addTarget:self action:@selector(divideCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 16:
                [btn addTarget:self action:@selector(multiplyCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 17:
                [btn addTarget:self action:@selector(minusCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 18:
                [btn addTarget:self action:@selector(addCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 19:
                [btn addTarget:self action:@selector(equal:) forControlEvents:UIControlEventTouchUpInside];
            default:
                break;
        }
        
        
        if((i>0&&i<4)||(i>5&&i<10)||(i>10&&i<14)){
            [btn addTarget:self action:@selector(addnum:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        else btn.tag = 250;
        //newLable.tag = 201 + cntx*3 + cnty;
        //3.添加到父视图

        [self.view addSubview:newView];
        //[newView addSubview:newLable];
        [newView addSubview:btn];
        cnty++;
        
        if(cnty == 5){
            cnty=0;cntx++;
        }
        
        //NSLog(@"view set is ok");
    }
}


@end
