//
//  RMTableViewCell.m
//  RMTimeLineDemo
//
//  Created by 王林 on 2017/5/26.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import "RMTableViewCell.h"

#define APP_SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define FONT_WITH_SIZE(a)       [UIFont systemFontOfSize:a]
//文字色- - 灰色
#define  CETC_GRAY_COLOR       [UIColor colorWithRed:138 / 255.0 green:138 / 255.0 blue:138 / 255.0 alpha:1]
//线条颜色
#define  CETC_GRAY_LINE_COLOR     [UIColor colorWithRed:229 / 255.0  green:229 / 255.0  blue:229 / 255.0  alpha:1]

@interface RMTableViewCell()

@property (strong, nonatomic)UIView *bgView;
@property (strong, nonatomic)UIImageView *clockImageView;
@property (strong, nonatomic)UILabel *contentLabel;

@end

@implementation RMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self.contentView addSubview:self.clockImageView];
		[self.contentView addSubview:self.bgView];
	}
	return self;
}


- (UIImageView *)clockImageView{
	if (!_clockImageView) {
		_clockImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 10, 10)];
		_clockImageView.image = [UIImage imageNamed:@"icon_time"];
		_clockImageView.hidden = YES;
	}
	return _clockImageView;
}


- (UILabel *)timeLabel{
	if (!_timeLabel) {
		_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 200, 15)];
		_timeLabel.font = FONT_WITH_SIZE(14);
		_timeLabel.textColor = CETC_GRAY_COLOR;
		[self.contentView addSubview:_timeLabel];
		
	}
	return _timeLabel;
}

- (UIView *)bgView{
	if (!_bgView) {
		_bgView = [[UIView alloc]initWithFrame:CGRectMake(40, 30, APP_SCREEN_WIDTH - 60, 40)];
		_bgView.backgroundColor = [UIColor whiteColor];
		_bgView.layer.masksToBounds = YES;
		_bgView.layer.cornerRadius = 4.0;
		_bgView.layer.borderWidth = 1.0;
		_bgView.layer.borderColor = CETC_GRAY_LINE_COLOR.CGColor;
	}
	return _bgView;
}


- (UILabel *)contentLabel{
	if (!_contentLabel) {
		_contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.bgView.frame) - 20, 20)];
		_contentLabel.font = FONT_WITH_SIZE(14);
		_contentLabel.textColor = CETC_GRAY_COLOR;
		_contentLabel.numberOfLines = 0;
		[self.bgView addSubview:_contentLabel];
	}
	return _contentLabel;
}

- (void)setTimeShow:(BOOL)timeShow{
	_timeShow = timeShow;
	self.clockImageView.hidden = !timeShow;
	if (timeShow) {
		CGRect frame = self.bgView.frame;
		frame.origin.y = 30;
		self.bgView.frame = frame;
		
		self.timeLabel.hidden = NO;
	}else{
		CGRect frame = self.bgView.frame;
		frame.origin.y = 5;
		self.bgView.frame = frame;
		
		self.timeLabel.hidden = YES;
	}
}


- (void)contentLabelText:(NSString *)text{
	self.contentLabel.text = text;
	CGFloat labelHeight = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentLabel.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:FONT_WITH_SIZE(14)} context:nil].size.height;
	
	CGRect frame = self.contentLabel.frame;
	frame.size.height = labelHeight;
	self.contentLabel.frame = frame;
	
	CGRect frame2 = self.bgView.frame;
	frame2.size.height = labelHeight + 20;
	self.bgView.frame = frame2;
}

- (CGFloat)cellHeight{
	return CGRectGetMaxY(self.bgView.frame) + 10;
}



@end
