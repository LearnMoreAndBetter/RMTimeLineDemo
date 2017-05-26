# RMTimeLineDemo
简单的时间轴，和动态缓存高度


这里用到了一个简单的思路，把时间轴的线条当做一条完整的线，然后通过scrollview的滚动，修改lineview的frame，这样就不需要在每一条cell中添加一条线段了
并且项目中针对线条做一个线条的渐变色
此外项目中还增加了一个动态缓存高度

UIView *bgView = [[UIView alloc]initWithFrame:self.tableView.bounds];
[bgView addSubview:self.lineView];
self.tableView.backgroundView = bgView;

如果项目中封装了frame对y的重设，可以自行优化减少代码的哦
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


- (UIView *)lineView{
	if (!_lineView) {
		_lineView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 2, APP_SCREEN_HEIGHT)];
//		_lineView.backgroundColor = CETC_GRAY_LINE_COLOR;
//		简单的线条渐变色
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


- (CGFloat)cellHeight{
return CGRectGetMaxY(self.bgView.frame) + 10;
}
