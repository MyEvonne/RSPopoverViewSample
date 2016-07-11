//
//  ViewController.m
//  RSPopoverViewSample
//
//  Created by Richard on 5/17/16.
//  Copyright © 2016 Richard. All rights reserved.
//

#import "ViewController.h"

#import "RSPopoverView/RSPopoverView.h"

static CGFloat const kViewControllerMarginToBounds = 10.f;

@interface ViewController ()
@property (strong, nonatomic) UIButton * leftTopButton;
@property (strong, nonatomic) UIButton * leftButton;
@property (strong, nonatomic) UIButton * leftBottomButton;
@property (strong, nonatomic) UIButton * bottomButton;
@property (strong, nonatomic) UIButton * rightBottomButton;
@property (strong, nonatomic) UIButton * rightButton;
@property (strong, nonatomic) UIButton * rightTopButton;
@property (strong, nonatomic) UIButton * topButton;
@property (strong, nonatomic) UIButton * centerButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftTopButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    CGRect frame = self.leftTopButton.frame;
    frame.origin.x = kViewControllerMarginToBounds;
    frame.origin.y = kViewControllerMarginToBounds;
    self.leftTopButton.frame = frame;
    [self.leftTopButton addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftTopButton];
    
    self.topButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    frame = self.topButton.frame;
    frame.origin.x = CGRectGetMidX(self.view.bounds) - frame.size.width / 2;
    frame.origin.y = kViewControllerMarginToBounds;
    self.topButton.frame = frame;
    [self.topButton addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.topButton];
    
    self.rightTopButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    frame = self.rightTopButton.frame;
    frame.origin.x = CGRectGetWidth(self.view.bounds) - frame.size.width - kViewControllerMarginToBounds;
    frame.origin.y = kViewControllerMarginToBounds;
    self.rightTopButton.frame = frame;
    [self.rightTopButton addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightTopButton];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    frame = self.leftButton.frame;
    frame.origin.x = kViewControllerMarginToBounds;
    frame.origin.y = CGRectGetMidY(self.view.bounds) - CGRectGetHeight(frame) / 2;
    self.leftButton.frame = frame;
    [self.leftButton addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    
    self.leftBottomButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    frame = self.leftBottomButton.frame;
    frame.origin.x = kViewControllerMarginToBounds;
    frame.origin.y = CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(frame) - kViewControllerMarginToBounds;
    self.leftBottomButton.frame = frame;
    [self.leftBottomButton addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftBottomButton];

    self.bottomButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    frame = self.bottomButton.frame;
    frame.origin.x = CGRectGetMidX(self.view.bounds) - CGRectGetWidth(frame) / 2;
    frame.origin.y = CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(frame) - kViewControllerMarginToBounds;
    self.bottomButton.frame = frame;
    [self.bottomButton addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bottomButton];
    
    self.rightBottomButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    frame = self.rightBottomButton.frame;
    frame.origin.x = CGRectGetMaxX(self.view.bounds) - CGRectGetWidth(frame) - kViewControllerMarginToBounds;
    frame.origin.y = CGRectGetMaxY(self.view.bounds) - CGRectGetHeight(frame) - kViewControllerMarginToBounds;
    self.rightBottomButton.frame = frame;
    [self.rightBottomButton addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightBottomButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onButtonClicked:(UIButton *)button {
    RSPopoverViewRowModel * firstRowModel = [[RSPopoverViewRowModel alloc] init];
    firstRowModel.text = @"11111111111";
    
    RSPopoverViewRowModel * secondRowModel = [[RSPopoverViewRowModel alloc] init];
    secondRowModel.text = @"22222222222";
    
    RSPopoverView * popoverView = [[RSPopoverView alloc] initWithRowModels:@[firstRowModel, secondRowModel]];
	popoverView.popoverViewMinMarginToView = 10;
    if (button == self.leftTopButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionLeft animated:YES];
    }
    else if (button == self.leftButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionLeft animated:YES];
    }
    else if (button == self.leftBottomButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionDown animated:YES];
    }
    else if (button == self.bottomButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionDown animated:YES];
    }
    else if (button == self.rightBottomButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionRight animated:YES];
    }
    else if (button == self.rightButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionRight animated:YES];
    }
    else if (button == self.rightTopButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionUp animated:YES];
    }
    else if (button == self.topButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionUp animated:YES];
    }
    else if (button == self.centerButton) {
        [popoverView presentPopoverFromRect:button.frame inView:self.view permittedArrowDirections:RSPopoverViewArrowDirectionUp animated:YES];
    }
}

@end
