//
//  RSPopoverView.m
//
//  Created by Richard on 3/31/16.
//  Copyright © 2016 Anjuke. All rights reserved.
//

#import "RSPopoverView.h"

@implementation RSPopoverViewRowModel

@end

CGFloat const kRSPopoverViewMarginToView = 5.f;

CGFloat const kRSPopoverViewDefaultRowHeight = 45.f;
CGFloat const kRSPopoverViewContentTableViewDefaultWidth = 130.f;
CGFloat const kRSPopoverViewContentTableViewLeftInset = 11.f;
CGFloat const kRSPopoverViewContentTableViewRightInset = 11.f;
CGFloat const kRSPopoverViewContentTableViewTopInset = 11.f;
CGFloat const kRSPopoverViewContentTableViewBottomInset = 11.f;
CGFloat const kRSPopoverViewContentTableViewLineViewHeight = 0.5f;

CGFloat const kRSPopoverViewBgLayerViewArrowMarginToRect = 2.f;
CGFloat const kRSPopoverViewBgLayerViewPaddingToTableView = 2.f;
CGFloat const kRSPopoverViewBgLayerLineWidth = 0.5f;
CGFloat const kRSPopoverViewBgLayerCornerRadius = 5.f;
CGFloat const kRSPopoverViewBgLayerArrowWidth = 14.f;
CGFloat const kRSPopoverViewBgLayerArrowHeight = 7.f;

@interface RSPopoverView () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIView * bgView;
@property (strong, nonatomic) UITableView * contentTableView;
@property (strong, nonatomic) CAShapeLayer * bgLayer;

@property (weak, nonatomic) UIView * parentView;

@property (assign, nonatomic) RSPopoverViewArrowDirection arrowDirection;
@property (assign, nonatomic) CGRect fromRect;
@end

@implementation RSPopoverView
#pragma mark - View Life Cycle
- (instancetype)initWithRowModels:(NSArray *)rowModels {
    self = [super init];
    if (self) {
        if (!(rowModels && rowModels.count > 0)) {
            return nil;
        }
        self.rowWidth = kRSPopoverViewContentTableViewDefaultWidth;
        self.rowHeight = kRSPopoverViewDefaultRowHeight;
        self.cornerRadius = kRSPopoverViewBgLayerCornerRadius;
        self.edgeInsets = UIEdgeInsetsMake(kRSPopoverViewBgLayerViewPaddingToTableView,
                                           kRSPopoverViewBgLayerViewPaddingToTableView,
                                           kRSPopoverViewBgLayerViewPaddingToTableView,
                                           kRSPopoverViewBgLayerViewPaddingToTableView);
        self.rowModels = rowModels;
        self.popoverBackgroundColor = [UIColor colorWithRed:0.29 green:0.32 blue:0.34 alpha:1.00];
		self.textColor = [UIColor whiteColor];
		self.textFont = [UIFont systemFontOfSize:15];
		self.popoverViewMinMarginToView = kRSPopoverViewMarginToView;
		self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		self.separatorColor = [UIColor lightGrayColor];
    }
    return self;
}

#pragma mark - Publich Methods
- (void)presentPopoverFromRect:(CGRect)rect
                        inView:(UIView *)view
      permittedArrowDirections:(RSPopoverViewArrowDirection)arrowDirections
                      animated:(BOOL)animated {
    self.fromRect = rect;
    self.parentView = view;
    self.arrowDirection = arrowDirections;
    self.frame = view.bounds;
    [self.parentView addSubview:self];
    
    [self layoutBgView];
    
    [view addSubview:self];
}

- (void)dismissPopoverAnimated:(BOOL)animated {
    [self removeFromSuperview];
}

#pragma mark - Layout Views
- (CGRect)calculateBgViewFrame {
    CGFloat tableViewWidth = self.rowWidth;
    CGFloat tableViewHeight = self.rowHeight * self.rowModels.count;

    CGFloat width, height, xPos, yPos, arrowXPos, arrowYPos;

    switch (self.arrowDirection) {
        case RSPopoverViewArrowDirectionUp: {
            width = tableViewWidth + self.edgeInsets.left + self.edgeInsets.right;
            height = tableViewHeight + self.edgeInsets.top + self.edgeInsets.bottom + kRSPopoverViewBgLayerArrowHeight;
            yPos = CGRectGetMaxY(self.fromRect) + kRSPopoverViewBgLayerViewArrowMarginToRect;
            arrowXPos = CGRectGetMidX(self.fromRect);
            if (arrowXPos < (self.popoverViewMinMarginToView + width / 2)) {
                //箭头在左边。
                xPos = self.popoverViewMinMarginToView;
            }
            else if (arrowXPos > (CGRectGetWidth(self.frame) - self.popoverViewMinMarginToView - width / 2)) {
                //箭头在右边
                xPos = CGRectGetWidth(self.frame) - self.popoverViewMinMarginToView - width;
            }
            else {
                xPos = arrowXPos - width / 2;
            }
            break;
        }
        case RSPopoverViewArrowDirectionDown: {
            width = tableViewWidth + self.edgeInsets.left + self.edgeInsets.right;
            height = tableViewHeight + self.edgeInsets.top + self.edgeInsets.bottom + kRSPopoverViewBgLayerArrowHeight;
            yPos = CGRectGetMinY(self.fromRect) - kRSPopoverViewBgLayerViewArrowMarginToRect - height;
            arrowXPos = CGRectGetMidX(self.fromRect);
            if (arrowXPos < (self.popoverViewMinMarginToView + width / 2)) {
                //箭头在左边。
                xPos = self.popoverViewMinMarginToView;
            }
            else if (arrowXPos > (CGRectGetWidth(self.frame) - self.popoverViewMinMarginToView - width / 2)) {
                //箭头在右边
                xPos = CGRectGetWidth(self.frame) - self.popoverViewMinMarginToView - width;
            }
            else {
                xPos = arrowXPos - width / 2;
            }
            break;
        }
        case RSPopoverViewArrowDirectionLeft: {
            width = tableViewWidth + self.edgeInsets.left + self.edgeInsets.right + kRSPopoverViewBgLayerArrowHeight;
            height = tableViewHeight + self.edgeInsets.top + self.edgeInsets.bottom;
            xPos = CGRectGetMaxX(self.fromRect) + kRSPopoverViewBgLayerViewArrowMarginToRect;
            arrowYPos = CGRectGetMidY(self.fromRect);
            if (arrowYPos < (self.popoverViewMinMarginToView + height / 2)) {
                //箭头在上边。
                yPos = self.popoverViewMinMarginToView;
            }
            else if (arrowYPos > (CGRectGetHeight(self.frame) - self.popoverViewMinMarginToView - height / 2)) {
                //箭头在下边
                yPos = CGRectGetHeight(self.frame) - self.popoverViewMinMarginToView - height;
            }
            else {
                yPos = arrowYPos - height / 2;
            }
            break;
        }
        case RSPopoverViewArrowDirectionRight: {
            width = tableViewWidth + self.edgeInsets.left + self.edgeInsets.right + kRSPopoverViewBgLayerArrowHeight;
            height = tableViewHeight + self.edgeInsets.top + self.edgeInsets.bottom;
            xPos = CGRectGetMinX(self.fromRect) - kRSPopoverViewBgLayerViewArrowMarginToRect - width;
            arrowYPos = CGRectGetMidY(self.fromRect);
            if (arrowYPos < (self.popoverViewMinMarginToView + height / 2)) {
                //箭头在上边。
                yPos = self.popoverViewMinMarginToView;
            }
            else if (arrowYPos > (CGRectGetHeight(self.frame) - self.popoverViewMinMarginToView - height / 2)) {
                //箭头在下边
                yPos = CGRectGetHeight(self.frame) - self.popoverViewMinMarginToView - height;
            }
            else {
                yPos = arrowYPos - height / 2;
            }
            break;
        }
    }
    return CGRectMake(xPos, yPos, width, height);
}

#pragma mark - Layout BgLayer Methods
- (void)layoutBgView {
    CGRect bgViewFrame = [self calculateBgViewFrame];
    self.bgView = [[UIView alloc] initWithFrame:bgViewFrame];
    [self addSubview:self.bgView];
    
    CAShapeLayer * bgLayer = [CAShapeLayer layer];
    bgLayer.frame = self.bgView.bounds;
    
    CGPoint arrowPointInBg;
    UIBezierPath * path;
    //画背景图。
    //先计算箭头在bgLayer中的起始点。
    switch (self.arrowDirection) {
        case RSPopoverViewArrowDirectionUp: {
            arrowPointInBg = CGPointMake(CGRectGetMidX(self.fromRect) - CGRectGetMinX(bgViewFrame), 0) ;
            path = [self pathForArrowUpInFrame:bgLayer.frame arrowPoint:arrowPointInBg];
            break;
        }
        case RSPopoverViewArrowDirectionDown: {
            arrowPointInBg = CGPointMake(CGRectGetMidX(self.fromRect) - CGRectGetMinX(bgViewFrame),
                                         CGRectGetHeight(bgViewFrame)) ;
            path = [self pathForArrowDownInFrame:bgLayer.frame arrowPoint:arrowPointInBg];
            break;
        }
        case RSPopoverViewArrowDirectionLeft: {
            arrowPointInBg = CGPointMake(0, CGRectGetMidY(self.fromRect) - CGRectGetMinY(bgViewFrame)) ;
            path = [self pathForArrowLeftInFrame:bgLayer.frame arrowPoint:arrowPointInBg];
            break;
        }
        case RSPopoverViewArrowDirectionRight: {
            arrowPointInBg = CGPointMake(CGRectGetWidth(bgViewFrame), CGRectGetMidY(self.fromRect) - CGRectGetMinY(bgViewFrame)) ;
            path = [self pathForArrowRightInFrame:bgLayer.frame arrowPoint:arrowPointInBg];
            break;
        }
    }
    bgLayer.strokeColor = self.popoverBackgroundColor.CGColor;
    bgLayer.fillColor = self.popoverBackgroundColor.CGColor;
    bgLayer.lineWidth = kRSPopoverViewBgLayerLineWidth;
    bgLayer.lineJoin = kCALineJoinBevel;
    bgLayer.path = path.CGPath;
    
    [self.bgView.layer addSublayer:bgLayer];
    [self layoutContentTableView];
}

- (UIBezierPath *)pathForArrowUpInFrame:(CGRect)frame arrowPoint:(CGPoint)arrowPoint {
    CGRect rect = CGRectMake(0, kRSPopoverViewBgLayerArrowHeight, CGRectGetWidth(frame), CGRectGetHeight(frame) - kRSPopoverViewBgLayerArrowHeight);//计算出圆角矩形的大小。
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];//先画出圆角矩形。
    //开始画箭头。
    [path moveToPoint:CGPointMake(arrowPoint.x - kRSPopoverViewBgLayerArrowWidth / 2, kRSPopoverViewBgLayerArrowHeight)];
    [path addLineToPoint:arrowPoint];
    [path addLineToPoint:CGPointMake(arrowPoint.x + kRSPopoverViewBgLayerArrowWidth / 2, kRSPopoverViewBgLayerArrowHeight)];
    return path;
}

- (UIBezierPath *)pathForArrowDownInFrame:(CGRect)frame arrowPoint:(CGPoint)arrowPoint {
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) - kRSPopoverViewBgLayerArrowHeight);//计算出圆角矩形的大小。
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];//先画出圆角矩形。
    //开始画箭头。
    [path moveToPoint:CGPointMake(arrowPoint.x - kRSPopoverViewBgLayerArrowWidth / 2, CGRectGetMaxY(rect))];
    [path addLineToPoint:arrowPoint];
    [path addLineToPoint:CGPointMake(arrowPoint.x + kRSPopoverViewBgLayerArrowWidth / 2, CGRectGetMaxY(rect))];
    return path;
}

- (UIBezierPath *)pathForArrowLeftInFrame:(CGRect)frame arrowPoint:(CGPoint)arrowPoint {
    CGRect rect = CGRectMake(kRSPopoverViewBgLayerArrowHeight, 0, CGRectGetWidth(frame) - kRSPopoverViewBgLayerArrowHeight, CGRectGetHeight(frame));//计算出圆角矩形的大小。
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];//先画出圆角矩形。
    //开始画箭头。
    [path moveToPoint:CGPointMake(kRSPopoverViewBgLayerArrowHeight, arrowPoint.y - kRSPopoverViewBgLayerArrowWidth / 2)];
    [path addLineToPoint:arrowPoint];
    [path addLineToPoint:CGPointMake(kRSPopoverViewBgLayerArrowHeight, arrowPoint.y + kRSPopoverViewBgLayerArrowWidth / 2)];
    return path;
}

- (UIBezierPath *)pathForArrowRightInFrame:(CGRect)frame arrowPoint:(CGPoint)arrowPoint {
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(frame) - kRSPopoverViewBgLayerArrowHeight, CGRectGetHeight(frame));//计算出圆角矩形的大小。
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];//先画出圆角矩形。
    //开始画箭头。
    [path moveToPoint:CGPointMake(CGRectGetMaxX(rect), arrowPoint.y - kRSPopoverViewBgLayerArrowWidth / 2)];
    [path addLineToPoint:arrowPoint];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect), arrowPoint.y + kRSPopoverViewBgLayerArrowWidth / 2)];
    return path;
}


#pragma mark - Layout Content TableView Methods
- (void)layoutContentTableView {
    CGRect frame = self.bgView.bounds;
    frame.size.width = self.rowWidth;
    frame.size.height = self.rowHeight * self.rowModels.count;
    switch (self.arrowDirection) {
        case RSPopoverViewArrowDirectionUp: {
            frame.origin.x += self.edgeInsets.left;
            frame.origin.y += kRSPopoverViewBgLayerArrowHeight + self.edgeInsets.top;
            break;
        }
        case RSPopoverViewArrowDirectionDown: {
            frame.origin.x += self.edgeInsets.left;
            frame.origin.y += self.edgeInsets.top;
            break;
        }
        case RSPopoverViewArrowDirectionLeft: {
            frame.origin.x += self.edgeInsets.left + kRSPopoverViewBgLayerArrowHeight;
            frame.origin.y += self.edgeInsets.top;
            break;
        }
        case RSPopoverViewArrowDirectionRight: {
            frame.origin.x += self.edgeInsets.left;
            frame.origin.y += self.edgeInsets.top;
            break;
        }
    }
    self.contentTableView = [[UITableView alloc] initWithFrame:frame];
    self.contentTableView.backgroundColor = [UIColor clearColor];
    self.contentTableView.scrollEnabled = NO;
    self.contentTableView.showsVerticalScrollIndicator = NO;
    self.contentTableView.showsHorizontalScrollIndicator = NO;
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.separatorStyle = self.separatorStyle;
	self.contentTableView.separatorColor = self.separatorColor;
    self.contentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentTableView.frame), 0.5)];
    self.contentTableView.layer.masksToBounds = NO;
    [self.bgView addSubview:self.contentTableView];
}

#pragma mark - Setters
- (void)setRowModels:(NSArray *)rowModels {
    _rowModels = rowModels;
	[self.contentTableView reloadData];
}

- (void)setTextColor:(UIColor *)textColor {
	_textColor = textColor;
	[self.contentTableView reloadData];
}

- (void)setTextFont:(UIFont *)textFont {
	_textFont = textFont;
	[self.contentTableView reloadData];
}

- (void)setRowWidth:(CGFloat)rowWidth {
	_rowWidth = rowWidth;
	[self layoutIfNeeded];
}

- (void)setRowHeight:(CGFloat)rowHeight {
	_rowHeight = rowHeight;
	[self layoutIfNeeded];
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
	_edgeInsets = edgeInsets;
	[self layoutIfNeeded];
}

- (void)setPopoverViewMinMarginToView:(CGFloat)popoverViewMinMarginToView {
	_popoverViewMinMarginToView = popoverViewMinMarginToView;
	[self layoutIfNeeded];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	_cornerRadius = cornerRadius;
	[self layoutIfNeeded];
}

- (void)setPopoverBackgroundColor:(UIColor *)popoverBackgroundColor {
	_popoverBackgroundColor = popoverBackgroundColor;
	[self layoutIfNeeded];
}

- (void)setSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle {
	self.contentTableView.separatorStyle = separatorStyle;
	[self layoutIfNeeded];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
	self.contentTableView.separatorColor = separatorColor;
	[self layoutIfNeeded];
}

#pragma mark - Actions
- (void)onBgViewTapped:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self dismissPopoverAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissPopoverAnimated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.rowHeight > 0) {
        return self.rowHeight;
    }
    return kRSPopoverViewDefaultRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(indexPath.row);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.rowModels) {
        return self.rowModels.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSPopoverViewRowModel * rowModel = self.rowModels[indexPath.row];
    NSString * cellId = @"UITableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = self.textColor;
        cell.textLabel.font = self.textFont;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (indexPath.row < self.rowModels.count - 1) {
        NSInteger lineTag = 1000000;
        UIView * lineView = [cell viewWithTag:lineTag];
        if (!lineView) {
            lineView = [[UIView alloc] initWithFrame:CGRectMake(kRSPopoverViewContentTableViewLeftInset,
                                                                kRSPopoverViewDefaultRowHeight - kRSPopoverViewContentTableViewLineViewHeight,
                                                                CGRectGetWidth(tableView.frame) - kRSPopoverViewContentTableViewLeftInset - kRSPopoverViewContentTableViewRightInset,
                                                                kRSPopoverViewContentTableViewLineViewHeight)];
            lineView.tag = lineTag;
            lineView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:lineView];
        }
    }
    if (rowModel.iconImage) {
        cell.imageView.image = rowModel.iconImage;
    }
    cell.textLabel.text = rowModel.text;
    return cell;
}
@end
