//
//  RMTableViewCell.h
//  RMTimeLineDemo
//
//  Created by 王林 on 2017/5/26.
//  Copyright © 2017年 wanglin. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const RMTableViewCellIdentifier = @"RMTableViewCellIdentifier";
@interface RMTableViewCell : UITableViewCell

@property (strong, nonatomic)UILabel *timeLabel;
@property (assign, nonatomic)BOOL timeShow;

- (void)contentLabelText:(NSString *)text;

- (CGFloat)cellHeight;

@end
