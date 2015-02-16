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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [self showActivity];
    
    __weak typeof(self) __self = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [__self hideActivity];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showActivity];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [__self hideActivity];
                ViewController* ctrl = [__self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                [__self.navigationController pushViewController:ctrl animated:YES];
            });
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
