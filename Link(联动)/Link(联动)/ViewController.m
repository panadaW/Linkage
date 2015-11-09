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
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property(nonatomic,assign) NSInteger currentindex;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property(nonatomic,strong)NSMutableArray *imagearray;
@property(nonatomic,strong)UIImageView *imageview;
@end

@implementation ViewController
//懒加载
-(NSMutableArray *)imagearray {
    if (_imagearray == nil) {
        _imagearray = [NSMutableArray array];
        for (int i = 0; i <= 4; i++) {
             [_imagearray addObject:[NSString stringWithFormat:@"img_0%d",i]];
        }
       }
    return _imagearray;

}
//懒加载
-(UIImageView *)imageview {
    if (_imageview == nil) {
        _imageview = [[UIImageView alloc]initWithFrame:self.collectionview.frame];
    }
    return _imageview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionview.delegate = self;
    self.link.constant = 0;
    [self setupChannel];
}

-(void)viewDidLayoutSubviews {
    self.layout.itemSize = self.collectionview.bounds.size;
    self.collectionview.pagingEnabled = YES;
    self.layout.minimumInteritemSpacing=0;
    self.layout.minimumLineSpacing = 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagearray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    for (int i = 0; i <=4; i++) {
        
        self.imageview.image = [UIImage imageNamed:self.imagearray[i]];
        [cell addSubview:self.imageview];
    }
   
    
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
            CGFloat x = self.collectionview.contentOffset.x;
        self.link.constant = x;
//    NSArray *indexpaths = [self.collectionview indexPathsForVisibleItems];
//    NSLog(@"%@",indexpaths);
    [self setupChannel];
   
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentindex = self.collectionview.contentOffset.x/self.collectionview.frame.size.width;
    NSLog(@"%ld",(long)self.currentindex);
   [self setupChannel];
}
- (void)setupChannel {
    
    // *** 取消 scrollView 的自动缩进
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.scrollview.subviews[self.currentindex] reloadInputViews];
    // 遍历频道数组，添加 label
    CGFloat margin = 8.0;
    CGFloat x = margin;
    CGFloat h = self.scrollview.bounds.size.height;
    
    // 设置 contentSize
    self.scrollview.contentSize = CGSizeMake(x + margin, h);
    
    // 当前选中第0项
       // 设置第0个label的scale
    UILabel *lab = self.scrollview.subviews[self.currentindex];
    lab.font = [UIFont systemFontOfSize:18];
    // 根据大字体设置大小
    [lab sizeToFit];
    [lab setUserInteractionEnabled:YES];
    // 设置成小字体
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = [UIColor redColor];
    float nextScale = ABS((float)self.collectionview.contentOffset.x / self.collectionview.bounds.size.width - self.currentindex);
//    float currentScale = 1 - nextScale;
    CGFloat prsent = 2/7;
    CGFloat scale = prsent *nextScale + 1;
    lab.transform = CGAffineTransformMakeScale(scale, scale);
}

@end
