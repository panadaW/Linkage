//
//  ViewController.m
//  标签滚动
//
//  Created by 王明申 on 15/11/9.
//  Copyright © 2015年 晨曦的Mac. All rights reserved.
//

#import "ViewController.h"
#define CZNormalFontSize 14.0
#define CZSelectedFontSize 18.0
#import "MyLable.h"
#import "MyCollectionCell.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyLableDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property(nonatomic,assign)NSInteger currentindex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self prepareForCollectionview];

}
//设置collectionview属性
-(void)prepareForCollectionview {
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = self.collectionview.bounds.size;
//[self.collectionview registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionview.pagingEnabled = YES;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;

}
//添加控件
-(void)setUpUI {
    CGFloat magrn = 8;
    CGFloat x = magrn;
     CGFloat h = self.scrollview.bounds.size.height;
    NSInteger index = 0;
    for (int i = 0; i < 10; i++) {
        MyLable *lable = [MyLable setUpLable:[NSString stringWithFormat:@"标签%d",i]];
        lable.frame = CGRectMake(x, 0,lable.bounds.size.width , h);
        x+=lable.bounds.size.width;
        [self.scrollview addSubview:lable];
        lable.delegate = self;
        lable.tag = index++;
    }
    self.scrollview.contentSize = CGSizeMake(x +magrn, h);
    self.scrollview.backgroundColor = [UIColor yellowColor];
    self.currentindex = 0;
    MyLable *lable = self.scrollview.subviews[0];
    lable.scale = 1;
}
//数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0) green:((float)arc4random_uniform(256)/255.0) blue:((float)arc4random_uniform(256)/255.0) alpha:1.0];
    return cell;

}

// 代理方法,只要滚动就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    MyLable *lableN = self.scrollview.subviews[self.currentindex];

    NSArray *indexpaths = [self.collectionview indexPathsForVisibleItems];
//    NSLog(@"%@",indexpaths);
    MyLable *lableNext = nil;
//    循环便利数组
    for (NSIndexPath *path in indexpaths) {
        if (path.item != self.currentindex) {
//            下一个标签
            lableNext = self.scrollview.subviews[path.item];
           
            break;
        }
    }
    if (lableNext == nil) {
        return;
    }
    float nextscale = ABS((float)self.collectionview.contentOffset.x / self.collectionview.bounds.size.width - self.currentindex);
    float scale = 1 - nextscale;

    lableNext.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    lableN.scale = scale;
    lableNext.scale = nextscale;
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//更新索引
    self.currentindex = scrollView.contentOffset.x/scrollView.bounds.size.width;

}
//lable代理方法
-(void)MyLableDidSelect:(UILabel *)lable {
    NSLog(@"%@",lable);
    self.currentindex = lable.tag;
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:self.currentindex inSection:0];
//    滚动到相应的索引
    [self.collectionview scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
  
}
@end
