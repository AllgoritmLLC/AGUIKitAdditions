//
//  ViewController.m
//  AGUIKitAdditionsExamples
//
//  Created by develop on 16/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "ViewController.h"

#import "AGUIKitAdditions.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView* tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 500)];
    tableHeaderView.backgroundColor = [UIColor yellowColor];
    
    UILabel* lbHello = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 21)];
    lbHello.text = @"Hello";
    lbHello.translatesAutoresizingMaskIntoConstraints = NO;
    
    [tableHeaderView addSubview:lbHello];
    [tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[label]-0-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"label":    lbHello}]];
    [tableHeaderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"label":    lbHello}]];
    NSLayoutConstraint* constraint = [NSLayoutConstraint constraintWithItem:tableHeaderView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:lbHello
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:0];
    constraint.priority = 999;
    [tableHeaderView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:tableHeaderView
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                 toItem:lbHello
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1
                                               constant:0];
    constraint.priority = 1000;
    [tableHeaderView addConstraint:constraint];
    
    self.tableView.tableHeaderView = tableHeaderView;
}

-(void)viewDidAppear:(BOOL)animated{
    __weak typeof(self) __self = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [__self.tableView sizeTableHeaderViewToFit];
    });
    
//    [self showActivity];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [__self hideActivity];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self showActivity];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [__self hideActivity];
//                ViewController* ctrl = [__self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//                [__self.navigationController pushViewController:ctrl animated:YES];
//            });
//        });
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
