//
//    The MIT License (MIT)
//
//    Copyright (c) 2015 Allgoritm LLC
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

#import "UIViewController+AGAdditionsActivity.h"

#import <objc/runtime.h>

@implementation UIViewController (AGAdditionsActivity)

#pragma makr - associated objects
- (UIView *) vActivity {
    UIView* view = objc_getAssociatedObject(self, @selector(vActivity));
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        view.layer.cornerRadius = 12.0f;
        view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8f];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(==width)]"
                                                                     options:0
                                                                     metrics:@{@"width":    @(view.bounds.size.width)}
                                                                       views:@{@"view":     view}]];
        [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(==height)]"
                                                                     options:0
                                                                     metrics:@{@"height":   @(view.bounds.size.height)}
                                                                       views:@{@"view":     view}]];
        UIActivityIndicatorView* activity = [self activityIndicator];
        activity.center = CGPointMake(view.bounds.size.width / 2,
                                      view.bounds.size.height / 2);
        [view addSubview:activity];
        
        objc_setAssociatedObject(self, @selector(vActivity), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return view;
}

- (UIActivityIndicatorView *) activityIndicator {
    UIActivityIndicatorView* activity = objc_getAssociatedObject(self, @selector(activityIndicator));
    if (activity == nil) {
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        objc_setAssociatedObject(self, @selector(activityIndicator), activity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return activity;
}

- (NSNumber*) shownNumberOfTimes {
    NSNumber* times = objc_getAssociatedObject(self, @selector(shownNumberOfTimes));
    if (times == nil) {
        times = @(0);
        objc_setAssociatedObject(self, @selector(shownNumberOfTimes), times, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return times;
}

- (void) setShownNumberOfTimes:(NSNumber*)numberOfTimes {
    objc_setAssociatedObject(self, @selector(shownNumberOfTimes), numberOfTimes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger) shownTimes {
    return [[self shownNumberOfTimes] integerValue];
}

- (void) setShownTimes:(NSInteger)times {
    [self setShownNumberOfTimes:@(times)];
}

#pragma mark - public
- (void) showActivity {
    if ([self shownTimes] == 0) {
        self.vActivity.center = CGPointMake(self.view.bounds.size.width / 2,
                                            self.view.bounds.size.height / 2);
        [self.view addSubview:self.vActivity];
        
        [self.activityIndicator startAnimating];
        
        self.view.userInteractionEnabled = NO;
    }
    [self setShownTimes:[self shownTimes] + 1];
}

- (void) hideActivity {
    if ([self shownTimes] == 1) {
        [self.vActivity removeFromSuperview];
        self.view.userInteractionEnabled = YES;
    }
    [self setShownTimes:[self shownTimes] - 1];
}

- (void) hideActivityTotal {
    [self setShownTimes:1];
    [self hideActivity];
}

@end
