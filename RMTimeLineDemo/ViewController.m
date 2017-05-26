//
//  ViewController.m
//  RMTimeLineDemo
//
//  Created by 王林 on 2017/5/26.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "ViewController.h"
#import "RMTableViewCell.h"

#define APP_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define APP_SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
//线条颜色
#define  CETC_GRAY_LINE_COLOR     [UIColor colorWithRed:229 / 255.0  green:229 / 255.0  blue:229 / 255.0  alpha:1]

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIView *lineView;
@property (copy, nonatomic)NSMutableDictionary *heightAtIndexPath;
@property (copy, nonatomic)NSMutableArray *dataLists;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.title = @"时间轴";
	[self addSubviews];
	[self addDataSource];
}

- (void)addDataSource{
	NSDictionary *dict1 = @{@"time" : @"2017-05-23", @"content" : @"我是小明，时间轴的老大"};
	NSDictionary *dict2 = @{@"time" : @"2017-05-23", @"content" : @"我是小明，时间轴的老大"};
	NSDictionary *dict3 = @{@"time" : @"2017-05-22", @"content" : @"我是小红，我不认识小明"};
	NSDictionary *dict4 = @{@"time" : @"2017-05-22", @"content" : @"我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明"};
	NSDictionary *dict5 = @{@"time" : @"2017-05-22", @"content" : @"我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明。"};
	NSDictionary *dict6 = @{@"time" : @"2017-05-22", @"content" : @"我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明"};
	NSDictionary *dict7 = @{@"time" : @"2017-05-20", @"content" : @"我是小明，时间轴的老大"};
	NSDictionary *dict8 = @{@"time" : @"2017-05-19", @"content" : @"我是小明，时间轴的老大"};
	NSDictionary *dict9 = @{@"time" : @"2017-05-18", @"content" : @"我是小红，我不认识小明"};
	NSDictionary *dict10 = @{@"time" : @"2017-05-18", @"content" : @"我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明我是小红，我不认识小明"};
	[self.dataLists addObject:dict1];
	[self.dataLists addObject:dict2];
	[self.dataLists addObject:dict3];
	[self.dataLists addObject:dict4];
	[self.dataLists addObject:dict5];
	[self.dataLists addObject:dict6];
	[self.dataLists addObject:dict7];
	[self.dataLists addObject:dict8];
	[self.dataLists addObject:dict9];
	[self.dataLists addObject:dict10];
	
	[self.tableView reloadData];
}

- (void)addSubviews{
	[self.view addSubview:self.tableView];
	UIView *bgView = [[UIView alloc]initWithFrame:self.tableView.bounds];
	[bgView addSubview:self.lineView];
	self.tableView.backgroundView = bgView;
}

#pragma mark- tableView delegate && dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return self.dataLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	RMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RMTableViewCellIdentifier];
	if (!cell) {
		cell = [[RMTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RMTableViewCellIdentifier];
		cell.backgroundColor = [UIColor clearColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	NSDictionary *dict = self.dataLists[indexPath.row];
	
	//这里显示与否的判断与数据相关，具体问题具体分析
	if (indexPath.row == 0) {
		cell.timeShow = YES;
	}else{
		NSDictionary *preDict = self.dataLists[indexPath.row - 1];
		cell.timeShow = ![preDict[@"time"] isEqualToString:dict[@"time"]];
	}
	
	cell.timeLabel.text = dict[@"time"];
	[cell contentLabelText:dict[@"content"]];
	
	//存储高度
	[self.heightAtIndexPath setObject:@([cell cellHeight]) forKey:indexPath];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
	if(height) {
		return height.floatValue;
	} else {
		return UITableViewAutomaticDimension;
	}
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (self.tableView.contentOffset.y > 20) {
		CGRect frame = self.lineView.frame;
		frame.origin.y = 0;
		self.lineView.frame = frame;
	}else{
		CGRect frame = self.lineView.frame;
		frame.origin.y = 20 - self.tableView.contentOffset.y;
		self.lineView.frame = frame;
	}
}


#pragma mark- lazying
- (UITableView *)tableView{
	if (!_tableView) {
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT) style:UITableViewStylePlain];
		tableView.showsVerticalScrollIndicator = NO;
		[tableView setDataSource:self];
		[tableView setDelegate:self];
		tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		tableView.backgroundColor = [UIColor whiteColor];
		
		_tableView = tableView;
	}
	return _tableView;
}

- (UIView *)lineView{
	if (!_lineView) {
		_lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 2, APP_SCREEN_HEIGHT)];
//		_lineView.backgroundColor = CETC_GRAY_LINE_COLOR;
		
		CAGradientLayer *gradientLayer = [CAGradientLayer layer];
		gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
		gradientLayer.locations = @[@0.3, @0.5, @1.0];
		gradientLayer.startPoint = CGPointMake(0, 0);
		gradientLayer.endPoint = CGPointMake(0, 1);
		gradientLayer.frame = _lineView.bounds;
		[_lineView.layer addSublayer:gradientLayer];
		
	}
	return _lineView;
}

- (NSMutableDictionary *)heightAtIndexPath{
	if (!_heightAtIndexPath) {
		_heightAtIndexPath = [NSMutableDictionary dictionary];
	}
	return _heightAtIndexPath;
}

- (NSMutableArray *)dataLists{
	if (!_dataLists) {
		_dataLists = [NSMutableArray array];
	}
	return _dataLists;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
