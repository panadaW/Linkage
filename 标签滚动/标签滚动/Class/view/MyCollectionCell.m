//
//  MyCollectionCell.m
//  标签滚动
//
//  Created by 王明申 on 15/11/10.
//  Copyright © 2015年 晨曦的Mac. All rights reserved.
//
#import "MyTableViewController.h"

#import "MyCollectionCell.h"
@interface MyCollectionCell()
@property(nonatomic,strong)MyTableViewController *vc;
@end
@implementation MyCollectionCell
-(void)awakeFromNib {
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"MyTableViewController" bundle:nil];
    self.vc = stroyboard.instantiateInitialViewController;
    [self addSubview:self.vc.view];

}
-(void)layoutSubviews {
    [super layoutSubviews];
    self.vc.view.frame = self.bounds;

}
@end
