/***********************************************************
 
 File name: TimeLineModel.h
 Author:    Lin Wang
 Description:
 时间轴model
 
 2019/3/14: Created
 
 ************************************************************/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeLineModel : NSObject

/** 消息时间 */
@property (nonatomic, copy) NSString *time;
/** 消息内容 */
@property (nonatomic, copy) NSString *content;
/** 是否显示时间条 */
@property (nonatomic, assign) BOOL isTimeShow;

/**
 初始化方法

 @param dic 字典
 @return TimeLineModel对象
 */
+ (instancetype)itemWithDict:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
