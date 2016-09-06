//
//  RSPopoverView.h
//
//  Created by Richard on 3/31/16.
//  Copyright © 2016 Anjuke. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - RSPopoverViewRowModel

@interface RSPopoverViewRowModel : NSObject
@property (strong, nonatomic) UIImage * iconImage;
@property (copy, nonatomic) NSString * text;
@end


#pragma mark - RSPopoverView

typedef NS_ENUM(NSInteger, RSPopoverViewArrowDirection) {
    RSPopoverViewArrowDirectionUp = 0,
    RSPopoverViewArrowDirectionDown,
    RSPopoverViewArrowDirectionLeft,
    RSPopoverViewArrowDirectionRight
};

extern CGFloat const kRSPopoverViewDefaultRowHeight;

@class RSPopoverView;
typedef void(^RSPopoverViewDidSelectRowBlock)(NSUInteger selectedRowIndex);

@interface RSPopoverView : UIView
/**
 *  每行显示的内容数组，其中每个元素都必须是RSPopoverViewRowModel的实例。
 */
@property (strong, nonatomic) NSArray * rowModels;
/**
 *  每行文字的颜色。
 */
@property (strong, nonatomic) UIColor * textColor;
/**
 *  每行文字的字体。
 */
@property (strong, nonatomic) UIFont * textFont;
/**
 *  每行的宽度，指的是中间可点击区域的宽度，背景宽度应该加上edgeInsets的left，right。
 */
@property (assign, nonatomic) CGFloat rowWidth;
/**
 *  行高，默认为kRSPopoverViewDefaultRowHeight。
 */
@property (assign, nonatomic) CGFloat rowHeight;
/**
 *  popoverView与所在的view的最小间距。
 */
@property (assign, nonatomic) CGFloat popoverViewMinMarginToView;
/**
 *  内容相对于背景的距离。
 */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
/**
 *  popoverView圆角半径。
 */
@property (assign, nonatomic) CGFloat cornerRadius;
/**
 *  弹出菜单的背景颜色。
 */
@property (strong, nonatomic) UIColor * popoverBackgroundColor;
/**
 *  是否显示分割线。
 */
@property (assign, nonatomic) BOOL showSeparator;
/**
 *  分割线的颜色。
 */
@property (strong, nonatomic) UIColor * separatorColor;
/**
 *  分割线缩进。
 */
@property (assign, nonatomic) UIEdgeInsets separatorInsets;

@property (copy, nonatomic) RSPopoverViewDidSelectRowBlock didSelectRowBlock;

/**
 *  用需要展示的数据源进行初始化的方法。
    目前必须用这个方法来初始化。
 *
 *  @param rowModels 需要展示的所有行的内容数组，其中每个元素都必须为RSPopoverViewRowModel的实例。
 *
 *  @return 返回RSPopoverView实例。
 */
- (instancetype)initWithRowModels:(NSArray *)rowModels;

/**
 *  Displays the popover and anchors it to the specified location in the view.
 *
 *  @param rect            The rectangle in view at which to anchor the popover window.
 *  @param view            The view containing the anchor rectangle for the popover.
 *  @param arrowDirections The arrow directions the popover is permitted to use.
                           You can use this value to force the popover to be positioned on a specific side of the rectangle.
                           This parameter is set RSPopoverViewArrowDirectionUp by default.
 *  @param animated        Specify YES to animate the presentation of the popover or NO to display it immediately.
 */
- (void)presentPopoverFromRect:(CGRect)rect
                        inView:(UIView *)view
      permittedArrowDirections:(RSPopoverViewArrowDirection)arrowDirections
                      animated:(BOOL)animated;
/**
 *  消除RSPopoverView。
 *
 *  @param animated 是否展现动画。
 */
- (void)dismissPopoverAnimated:(BOOL)animated;
@end
