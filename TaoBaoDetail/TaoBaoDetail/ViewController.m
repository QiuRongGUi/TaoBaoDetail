//
//  ViewController.m
//  白__Qiu--Demo1
//
//  Created by QIUGUI on 16/6/29.
//  Copyright © 2016年 asskl. All rights reserved.
//
#import "QRG_MJRefreshAutoFooter.h"
#import "QRG_MJRefreshNormalHeader.h"

#import "CollectionViewCell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define ARCCOLOR (arc4random() % 255/256.0)
#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UITableView *OneTable;
    UITableView *TwoTable;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    /** 底层view*/
    UIScrollView *mainScrollView = [[UIScrollView alloc] init];
    mainScrollView.scrollEnabled = NO;
    mainScrollView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    mainScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT * 2);
    mainScrollView.backgroundColor = [UIColor greenColor];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.bounces = YES;
    [self.view addSubview:mainScrollView];
    /** 第一页面 table*/    
    OneTable = [[UITableView alloc] init];
    OneTable.frame = CGRectMake(0,0, WIDTH, HEIGHT - 64);
    OneTable.separatorColor = [UIColor greenColor];
    OneTable.delegate = self;
    OneTable.dataSource = self;
    OneTable.rowHeight = 80;
    [mainScrollView addSubview:OneTable];
    /** 第二页面 scrollView*/        
    UIScrollView *TwoScrollView = [[UIScrollView alloc] init];
    TwoScrollView.frame = CGRectMake(0, HEIGHT + 64, WIDTH, HEIGHT - 64);
    TwoScrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT - 64);
    TwoScrollView.backgroundColor = [UIColor cyanColor];
    TwoScrollView.pagingEnabled = YES;
    TwoScrollView.bounces = NO;
    
    [mainScrollView addSubview:TwoScrollView];

    /** 第二页面 table*/    

    TwoTable = [[UITableView alloc] init];
    TwoTable.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 64);
    TwoTable.separatorColor = [UIColor redColor];
    TwoTable.delegate = self;
    TwoTable.dataSource = self;
    [TwoScrollView addSubview:TwoTable];
    
    /** 第二页面 UICollectionView*/    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];

    UICollectionView *TwoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) collectionViewLayout:flow];
    TwoCollectionView.backgroundColor = [UIColor lightTextColor];
    TwoCollectionView.delegate = self;
    TwoCollectionView.dataSource = self;
    [TwoScrollView addSubview:TwoCollectionView];
    
//    [TwoCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Coll"];

    [TwoCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Coll"];
    
    
    //设置UITableView 上拉加载
    OneTable.mj_footer = [QRG_MJRefreshAutoFooter footerWithRefreshingBlock:^{
        //上拉，执行对应的操作---改变底层滚动视图的滚动到对应位置
        //设置动画效果
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            //            self.scrollV.contentOffset = CGPointMake(0, IPHONE_H);
            [mainScrollView setContentOffset:CGPointMake(0, HEIGHT)];
            
        } completion:^(BOOL finished) {
            //结束加载
            [OneTable.mj_footer endRefreshing];
        }];
        
        
    }];
    
    //设置TwoCollectionView 有下拉操作
    TwoCollectionView.mj_header = [QRG_MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉执行对应的操作
        //        self.scrollV.contentOffset = CGPointMake(0,0);
        [UIView animateWithDuration:1 animations:^{
            [mainScrollView setContentOffset:CGPointMake(0, - 64)];
            
        }];
        
        //结束加载
        [TwoCollectionView.mj_header endRefreshing];
    }];
    
    //设置TwoTable 有下拉操作
    TwoTable.mj_header = [QRG_MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉执行对应的操作
        //        self.scrollV.contentOffset = CGPointMake(0,0);
        
        [UIView animateWithDuration:1 animations:^{
            [mainScrollView setContentOffset:CGPointMake(0, - 64)];
            
        }];        
        //结束加载
        [TwoTable.mj_header endRefreshing];
    }];
    

}

#pragma mark---------tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
      if([tableView isEqual:OneTable])
      {
          height = 80;
      }else
      {
          return 120;
      }
    return height;
    
        
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld--askl",indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"6"];
    return  cell;
    
}

#pragma mark---------CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Coll = @"Coll";
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Coll forIndexPath:indexPath];
    
//    cell.backgroundColor  =[UIColor greenColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
