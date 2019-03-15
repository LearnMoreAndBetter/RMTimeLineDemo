/***********************************************************
 
 File name: TimeLineVC.m
 Author:    wanglin
 Description:
 时间轴VC
 
 2019/3/14: Created
 
 ************************************************************/

#import "TimeLineVC.h"
#import "TimeLineModel.h"
#import "TimeLineCell.h"

/** cellID */
#define kTimeLineCellID @"TimeLineCellID"

@interface TimeLineVC ()<UITableViewDelegate, UITableViewDataSource>
/** UITableView */
@property (nonatomic, strong) UITableView *tableView;
/** 时间轴线条 */
@property (nonatomic, strong) UIView *bgLineView;
/** UITableView的背景 */
@property (nonatomic, strong) UIView *bgView;
/** 动态缓存cell高度 */
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;
/** 时间消息模型数组 */
@property (nonatomic, copy) NSArray<TimeLineModel *>*dataArr;

@end

@implementation TimeLineVC

#pragma mark - Life Circle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"本周工作内容";
    [self addSubviews];
    [self addDataSource];
}

#pragma mark - Public Method 公开方法（头文件声明的方法）
#pragma mark - System Delegate Method 系统自带的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.tableView.contentOffset.y > 20) {
        CGRect frame = self.bgLineView.frame;
        frame.origin.y = 0;
        self.bgLineView.frame = frame;
    }else{
        CGRect frame = self.bgLineView.frame;
        frame.origin.y = 20 - self.tableView.contentOffset.y;
        self.bgLineView.frame = frame;
    }
}
#pragma mark - System DataSource Method 系统自带的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineCellID];
    if (!cell) {
        cell = [[TimeLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTimeLineCellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    TimeLineModel *model = self.dataArr[indexPath.row];
    if (indexPath.row == 0) {
        model.isTimeShow = YES;
    }else{
        TimeLineModel *preModel = self.dataArr[indexPath.row - 1];
        model.isTimeShow = ![preModel.time isEqualToString:model.time];
    }
    cell.model = model;

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

#pragma mark - Custom Delegate Method 自定义的代理方法
#pragma mark - Event Response Method 事件响应方法
#pragma mark - Private Method 私有方法
- (void)addSubviews{
    [self.view addSubview:self.tableView];
    [self.tableView setBackgroundView:self.bgView];
    
}

- (void)addDataSource{
    NSDictionary *dict1 = @{@"time" : @"2019-03-15",
                            @"content" : @"完善demo"};
    NSDictionary *dict2 = @{@"time" : @"2019-03-15",
                            @"content" : @"熟悉图书管理系统"};
    NSDictionary *dict3 = @{@"time" : @"2019-03-14",
                            @"content" : @"【技术项目】参加新员工入职培训"};
    NSDictionary *dict4 = @{@"time" : @"2019-03-14",
                            @"content" : @"【技术项目】根据公司代码规范，试写一个简单的demo"};
    NSDictionary *dict5 = @{@"time" : @"2019-03-13",
                            @"content" : @"【技术项目】熟悉项目中的经销商app的代码架构，熟悉项目中的经销商app的代码架构，熟悉项目中的经销商app的代码架构，熟悉项目中的经销商app的代码架构，熟悉项目中的经销商app的代码架构，熟悉项目中的经销商app的代码架构"};
    NSDictionary *dict6 = @{@"time" : @"2019-03-13",
                            @"content" : @"【技术项目】熟悉项目中常用的sdk"};
    NSDictionary *dict7 = @{@"time" : @"2019-03-12",
                            @"content" : @"【技术项目】熟悉开发文档及公司的代码规范"};
    NSDictionary *dict8 = @{@"time" : @"2019-03-12",
                            @"content" : @"【技术项目】熟悉jira，confluence等工具的使用"};
    NSDictionary *dict9 = @{@"time" : @"2019-03-11",
                            @"content" : @"【技术项目】完善入职流程"};
    NSDictionary *dict10 = @{@"time" : @"2019-03-11",
                             @"content" : @"【技术项目】安装工作环境和开发环境"};
    NSArray *dataList = @[dict1, dict2, dict3, dict4, dict5, dict6, dict7, dict8, dict9, dict10];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in dataList) {
        TimeLineModel *model = [TimeLineModel itemWithDict:dic];
        [arr addObject:model];
    }
    self.dataArr = arr;
    
    [self.tableView reloadData];
}

#pragma mark - Getters and Setters Method getter和setter方法
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView = tableView;
        
    }
    return _tableView;
}

- (UIView *)bgLineView{
    if (!_bgLineView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 1, APP_SCREEN_HEIGHT)];
//        view.backgroundColor = GRAY_LINE_COLOR;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors =
            @[(__bridge id)[UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1.0].CGColor,
              (__bridge id)[UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.frame = view.bounds;
        [view.layer addSublayer:gradientLayer];
        
        _bgLineView = view;
    }
    return _bgLineView;
}

- (UIView *)bgView{
    if (!_bgView) {
        UIView *view = [[UIView alloc] initWithFrame:self.tableView.bounds];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [view addSubview:self.bgLineView];
        
        _bgView = view;
    }
    return _bgView;
}

- (NSMutableDictionary *)heightAtIndexPath{
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [NSMutableDictionary dictionary];
    }
    return _heightAtIndexPath;
}

@end
