/***********************************************************
 
 File name: TimeLineModel.m
 Author:    Lin Wang
 Description:
 时间轴model
 
 2019/3/14: Created
 
 ************************************************************/


#import "TimeLineModel.h"

@implementation TimeLineModel

+ (instancetype)itemWithDict:(NSDictionary *)dic{
    TimeLineModel *model = [[TimeLineModel alloc] init];
    model.time = [dic objectForKey:@"time"];
    model.content = [dic objectForKey:@"content"];
    
    return model;
}


@end
