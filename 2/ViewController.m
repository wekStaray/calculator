//
//  ViewController.m
//  2
//
//  Created by bytedance on 2020/7/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
@interface ViewController ()

-(void)Calculation;
-(void)clear:(UIButton*)it;

@property(nonatomic,strong) UILabel *text;
@property(nonatomic,strong) NSString *firstNumber;
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
    double num1 = [self.firstNumber doubleValue];
    double num2 = [self.secondNumber doubleValue];
    static long long inf = 100000000000000;
    switch (self.C){
        case 1:{
                tmp = num1 + num2;
                
                if(tmp >= inf){
                    self.text.text=@"Too big";
                    self.secondNumber = @"0";
                    self.firstNumber = nil;
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
                    self.firstNumber = nil;
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
                    self.firstNumber = nil;
                    self.isAfterCalculate = NO;
                    return;
                }
        }
                break;
        case 4:{
                    if([self isZero:num2]){
                    self.text.text=@"ERROR";
                    self.secondNumber = @"0";
                    self.firstNumber = nil;
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
                        self.firstNumber = nil;
                        self.isAfterCalculate = NO;
                        return;
                    }
        }
            break;
    }
    double num3 = tmp - (long long)tmp;
    
    self.firstNumber = self.text.text = [self isZero:num3]?[NSString stringWithFormat:@"%.0lf",tmp]:[NSString stringWithFormat:@"%lf",tmp];

}
-(void)equal:(UIButton*)it{
    if(self.firstNumber == nil) return;
        else [self Calculation];
    
    self.isInEqualCalculator = YES;
}
-(void)pointCalc:(UIButton*)it{
   // if(self.isInEqualCalculator) [self allClear:it];
    
    double num = [self.text.text doubleValue];
    
    double tmp = num - (long long)num;
    static unichar ch = (unichar)'.';
    
    if(![self isZero:tmp]) return;
    else if(ch == [self.text.text characterAtIndex:self.text.text.length-1])
        self.text.text = [self.text.text substringToIndex:(self.text.text.length-1)];
    else
        self.text.text = [NSString stringWithFormat:@"%@.",self.text.text];
    
    self.secondNumber=self.text.text;
}
-(void)addCalc:(UIButton*)it{
    self.C = 1;
    
    if(self.isInEqualCalculator){
      //  self.firstNumber = self.text.text;
        self.isInEqualCalculator = NO;
        self.isAfterCalculate = YES;
    }
    
     if(self.isAfterCalculate) return;
     
     if(self.firstNumber != nil ) [self Calculation];
     //else self.firstNumber = self.text.text;
    
     self.isAfterCalculate = YES;
}
-(void)minusCalc:(UIButton*)it{
    self.C = 2;
     
     if(self.isInEqualCalculator){
       //  self.firstNumber = self.text.text;
         self.isInEqualCalculator = NO;
         self.isAfterCalculate = YES;
     }
     
      if(self.isAfterCalculate) return;
      
      if(self.firstNumber != nil ) [self Calculation];
       //else self.firstNumber = self.text.text;
      
       self.isAfterCalculate = YES;
}
-(void)multiplyCalc:(UIButton*)it{
   self.C = 3;
    
    if(self.isInEqualCalculator){
       // self.firstNumber = self.text.text;
        self.isInEqualCalculator = NO;
        self.isAfterCalculate = YES;
    }
    
     if(self.isAfterCalculate) return;
     
     self.isAfterCalculate = YES;
     
     if(self.firstNumber != nil ) [self Calculation];
       // else self.firstNumber = self.text.text;
}
-(void)divideCalc:(UIButton*)it{
   self.C = 4;
    
    if(self.isInEqualCalculator){
  //      self.firstNumber = self.text.text;
        self.isInEqualCalculator = NO;
        self.isAfterCalculate = YES;
    }
    
     if(self.isAfterCalculate) return;
     
     if(self.firstNumber != nil ) [self Calculation];
   //   else self.firstNumber = self.text.text;
     
      self.isAfterCalculate = YES;
}
-(void)squareCalc:(UIButton*)it{
    self.C = 5;
     
    if(self.isInEqualCalculator){
        //self.firstNumber = self.text.text;
        self.isInEqualCalculator = NO;
        self.isAfterCalculate = YES;
    }
    
     if(self.isAfterCalculate) return;
     
     if(self.firstNumber != nil ) [self Calculation];
    //  else self.firstNumber = self.text.text;
     
      self.isAfterCalculate = YES;
}
-(void)sqrtCalc:(UIButton*)it{
    if(self.firstNumber == nil || self.isAfterCalculate ||self.isInEqualCalculator){
        double num = [self.text.text doubleValue];
        num = sqrt(num);
        double num3 = num - (long long)num;
        self.secondNumber = @"0";
        self.firstNumber = self.text.text = [self isZero:num3]?[NSString stringWithFormat:@"%.0lf",num]:[NSString stringWithFormat:@"%lf",num];
    }
    else{
        double num = [self.secondNumber doubleValue];
            
        self.secondNumber = [NSString stringWithFormat:@"%lf",sqrt(num)];
            
        [self Calculation];
    }
    //self.firstNumber = nil;
    self.isAfterCalculate = NO;
    self.isInEqualCalculator = YES;
}
-(void)addnum:(UIButton*)it{
    
    if(self.isAfterCalculate){
        self.firstNumber = self.text.text;
        self.secondNumber = self.text.text = @"0";
        self.isAfterCalculate = NO;
    }
    
    if(self.isInEqualCalculator) [self allClear:it];
    
    if(self.text.text.length == 12) return;
    
    NSString* str = [it titleForState:UIControlStateNormal];
    
    if([self.text.text isEqualToString:@"0"])
        self.text.text = str;
    else
        self.text.text = [NSString stringWithFormat:@"%@%@",self.text.text,str];
    
    self.secondNumber=self.text.text;
    //NSLog(@"%@",self.text.text);
}

-(void)backSpace:(UIButton*)it{
    if(self.isInEqualCalculator) return;
    if(self.text.text.length == 0) return;
    else if(self.text.text.length == 1) self.secondNumber = self.text.text=@"0";
    else
        self.secondNumber = self.text.text = [self.text.text substringToIndex:(self.text.text.length-1)];
}

-(void)allClear:(UIButton*)it{
    self.secondNumber=self.text.text=@"0";
    self.firstNumber = nil;
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
    
    CGFloat padding = 10.0;
    UIView *answerView = [UIView new];
    UIView *calcView = [UIView new];
    [self.view addSubview:answerView];
    [self.view addSubview:calcView];
    
    answerView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.05];
    answerView.layer.borderWidth = 2;
    answerView.layer.cornerRadius = 30;
    [answerView.layer setBorderColor: [[UIColor clearColor]CGColor]];
   // calcView.backgroundColor = [UIColor greenColor];
    
    [answerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(padding, padding, 0, padding));
        make.bottom.equalTo(calcView.mas_top).offset(-10);
    }];
    
    [calcView mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, padding, padding, padding));
        make.height.equalTo(answerView).multipliedBy(2);
    }];
    
    self.text = [UILabel new];
    [answerView addSubview:self.text];
    self.text.text = @"0" ;
    [self.text mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(answerView).offset(30);
        make.centerY.equalTo(answerView);
        make.height.equalTo(answerView);
    }];
    
    
    
    self.text.textColor = [UIColor blackColor];
    self.text.font = [UIFont systemFontOfSize:40];
    //text.backgroundColor = [UIColor redColor];
    //[self.text sizeToFit];
    
    int x,y;
    NSString *temp = @" <√/789*456-123+^0.=\0";
    UIView *lastLineView,*lastView;
    
    UIView *firstView = [UIView new];
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [calcView addSubview:firstView];
    [firstView addSubview:firstBtn];
    firstView.layer.borderWidth = 2;
    firstView.layer.cornerRadius = 20;
    [firstView.layer setMasksToBounds:YES];
    firstView.layer.backgroundColor = [[[UIColor blackColor]colorWithAlphaComponent:0.3] CGColor];
    [firstBtn setTitle:[temp substringWithRange:NSMakeRange(0, 1)] forState:UIControlStateNormal];
    [firstBtn setTitle:[temp substringWithRange:NSMakeRange(0, 1)] forState:UIControlStateHighlighted];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    firstBtn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.equalTo(calcView).offset(10);
        make.height.width.lessThanOrEqualTo(calcView);
    }];
    
    [firstBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.height.width.equalTo(firstView);
    }];
    
    [firstBtn setTitle:@"CE" forState:UIControlStateNormal];
    [firstBtn setTitle:@"CE" forState:UIControlStateHighlighted];
    [firstBtn addTarget:self action:@selector(allClear:) forControlEvents:UIControlEventTouchUpInside];
    
    lastLineView=lastView=firstView;
    
    for(int i = 1 ; i < 20 ; i++)
    {
        UIView *newView = [UIView new];
       UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [calcView addSubview:newView];
        [newView addSubview:btn];
        [newView.layer setMasksToBounds:YES];
        newView.layer.borderWidth = 2;
        newView.layer.cornerRadius = 20;
        newView.layer.backgroundColor = [[[UIColor blackColor]colorWithAlphaComponent:0.3] CGColor];
        [btn setTitle:[temp substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateNormal];
        [btn setTitle:[temp substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:25];
        btn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        x = i/4 ; y= i%4 ;
        
        [newView mas_makeConstraints:^(MASConstraintMaker *make){
            if(x==0) make.top.equalTo(calcView).offset(10);
            else if(x==4)
                make.bottom.equalTo(calcView).offset(-10);
            make.top.equalTo(lastLineView.mas_bottom).offset(10);
            
            if(y==0) make.left.equalTo(calcView).offset(10);
            else if(y==3)
                make.right.equalTo(calcView).offset(-10);
            make.left.equalTo(lastView.mas_right).offset(10);
        
            make.height.equalTo(firstView.mas_height);
            make.width.equalTo(firstView.mas_width);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.left.height.width.equalTo(newView);
        }];
        
        //@" <√/789*456-123+^0.=\0"
        lastView = newView;
        if(y == 3) lastLineView = newView;
        switch (i) {
            case 16:
                [btn addTarget:self action:@selector(squareCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [btn addTarget:self action:@selector(backSpace:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:{
                    [btn addTarget:self action:@selector(sqrtCalc:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 18:{
                [btn addTarget:self action:@selector(pointCalc:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 3:
                [btn addTarget:self action:@selector(divideCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 7:
                [btn addTarget:self action:@selector(multiplyCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 11:
                [btn addTarget:self action:@selector(minusCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 15:
                [btn addTarget:self action:@selector(addCalc:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 19:
                [btn addTarget:self action:@selector(equal:) forControlEvents:UIControlEventTouchUpInside];
            default:
                break;
        }
        
        
        if((i>3&&i<7)||(i>7&&i<11)||(i>11&&i<15)||(i==17)){
            [btn addTarget:self action:@selector(addnum:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        
    }
}


@end
