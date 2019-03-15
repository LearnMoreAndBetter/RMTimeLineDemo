/***********************************************************
 
 File name: TimeLineModel.h
 Author:    Lin Wang
 Description:
 时间轴cell
 
 2019/3/14: Created
 
 ************************************************************/

#import "TimeLineCell.h"
#import "TimeLineModel.h"

const CGFloat timeBgHeight = 30.0;

@interface TimeLineCell()
/** 时间条view */
@property (nonatomic, strong) UIView *timeBgView;
/** 时间label */
@property (nonatomic, strong) UILabel *timeLabel;
/** 时间logo */
@property (nonatomic, strong) UIImageView *clockImageView;
/** 消息内容背景view */
@property (nonatomic, strong) UIView *contentBgView;
/** 消息内容 */
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation TimeLineCell

#pragma mark - Life Circle 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
    }
    return self;
}

#pragma mark - Public Method 公开方法（头文件声明的方法）
- (CGFloat)cellHeight{
    return CGRectGetMaxY(self.contentBgView.frame) + 10;
}

#pragma mark - System Delegate Method 系统自带的代理方法
#pragma mark - System DataSource Method 系统自带的数据源方法
#pragma mark - Custom Delegate Method 自定义的代理方法
#pragma mark - Event Response Method 事件响应方法
#pragma mark - Private Method 私有方法
- (void)addSubviews{
    [self.contentView addSubview:self.timeBgView];
    [self.timeBgView addSubview:self.clockImageView];
    [self.timeBgView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView addSubview:self.contentLabel];
}

/**
 显示时间条
 */
- (void)showTimeView{
   self.timeBgView.hidden = NO;
    CGRect frame = self.contentBgView.frame;
    frame.origin.y = timeBgHeight;
    self.contentBgView.frame = frame;
}

/**
 隐藏时间条
 */
- (void)hiddenTimeView{
    self.timeBgView.hidden = YES;
    CGRect frame = self.contentBgView.frame;
    frame.origin.y = 0;
    self.contentBgView.frame = frame;
}


/**
 文本信息高度自适应

 @param text 消息text
 */
- (void)contentLabelText:(NSString *)text{
    self.contentLabel.text = text;
    CGFloat labelHeight = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentLabel.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLabel.font} context:nil].size.height;
    labelHeight = ceil(labelHeight);
    
    CGRect labelFrame = self.contentLabel.frame;
    labelFrame.size.height = labelHeight;
    self.contentLabel.frame = labelFrame;
    
    CGRect bgViewFrame = self.contentBgView.frame;
    bgViewFrame.size.height = labelHeight + 20;
    self.contentBgView.frame = bgViewFrame;
}

#pragma mark - Getters and Setters Method getter和setter方法
-(UIView *)timeBgView{
    if (!_timeBgView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, timeBgHeight)];
        
        _timeBgView = view;
    }
    return _timeBgView;
}

- (UIImageView *)clockImageView{
    if (!_clockImageView) {
        UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_time"]];
        imgView.center = CGPointMake(20.5, timeBgHeight/2.0);
        
        _clockImageView = imgView;
    }
    return _clockImageView;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 200, CGRectGetHeight(self.timeBgView.frame))];
        label.font = FONT_WITH_SIZE(14);
        label.textColor = GRAY_TEXT_COLOR;
        
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(40, 30, APP_SCREEN_WIDTH - 60, 20)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 4.0;
        view.layer.borderWidth = 1.0;
        view.layer.borderColor = GRAY_LINE_COLOR.CGColor;
        
        _contentBgView = view;
    }
    return _contentBgView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.contentBgView.frame) - 20, 20)];
        label.font = FONT_WITH_SIZE(14);
        label.textColor = GRAY_TEXT_COLOR;
        label.numberOfLines = 0;

        _contentLabel = label;
    }
    return _contentLabel;
}

- (void)setModel:(TimeLineModel *)model{
    self.timeLabel.text = model.time;
    [self contentLabelText:model.content];
    
    if (model.isTimeShow) {
        [self showTimeView];
    }else{
        [self hiddenTimeView];
    }
}

@end
