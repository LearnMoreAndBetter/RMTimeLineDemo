/***********************************************************
 
 File name: TimeLineModel.h
 Author:    Lin Wang
 Description:
 时间轴cell
 
 2019/3/14: Created
 
 ************************************************************/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TimeLineModel;
@interface TimeLineCell : UITableViewCell
/** TimeLineModel对象 */
@property (nonatomic, strong) TimeLineModel *model;
/** cell高度 */
- (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
