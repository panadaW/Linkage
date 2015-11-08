//
//  ViewController.m
//  Link(联动)
//
//  Created by 王明申 on 15/11/8.
//  Copyright © 2015年 晨曦的Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property(nonatomic,strong)UIDynamicAnimator *ani;
@property (weak, nonatomic) IBOutlet UIView *redview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *link;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionview.delegate = self;
    self.link.constant = 0;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    添加仿真器
//    UIDynamicAnimator *ani = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
//    self.ani = ani;
//    CGPoint point = [[touches anyObject]locationInView:self.view];
//    //    捕捉行为
//    
//    UISnapBehavior *snp = [[UISnapBehavior alloc]initWithItem:self.redview snapToPoint:point];
//    snp.damping = 0.5;
//    [self.ani addBehavior:snp];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 13;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [UIView animateWithDuration:12.0 animations:^{
        CGFloat x = self.collectionview.contentOffset.x;
        self.link.constant = x;
        
//        if (self.link.constant < 0 || self.link.constant > 209) {
//            self.link.constant = 1;
//        }
        
        
    } completion:^(BOOL finished) {
        NSLog(@"%f",self.link.constant);
    }];

}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    //    添加仿真器
//    UIDynamicAnimator *ani = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
//    self.ani = ani;
//    UITouch *touches = [[UITouch alloc]init];
//    
//    CGPoint point = [touches locationInView:self.view];
//    //    捕捉行为
//    
//    UISnapBehavior *snp = [[UISnapBehavior alloc]initWithItem:self.redview snapToPoint:point];
//    snp.damping = 0.5;
//    [self.ani addBehavior:snp];
//    
//    CGFloat x = self.collectionview.contentOffset.x;
//    self.link.constant = x;
//
//
//}
@end
