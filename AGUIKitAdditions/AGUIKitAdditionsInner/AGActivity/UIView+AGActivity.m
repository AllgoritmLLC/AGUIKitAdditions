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

#import "UIView+AGActivity.h"

#import <objc/runtime.h>

@implementation UIView (AGActivity)

#pragma mark - associated objects
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
        view.hidden = YES;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIActivityIndicatorView* activity = [self activityIndicator];
        activity.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:activity];
        
        [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:0
                                                            toItem:activity
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:0
                                                            toItem:activity
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
        
        [self addSubview:view];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:0
                                                            toItem:view
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:0
                                                            toItem:view
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
        
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
        self.vActivity.hidden = NO;
        [self.activityIndicator startAnimating];
        self.userInteractionEnabled = NO;
    }
    [self setShownTimes:[self shownTimes] + 1];
}

- (void) hideActivity {
    if ([self shownTimes] == 1) {
        self.vActivity.hidden = YES;
        self.userInteractionEnabled = YES;
    }
    [self setShownTimes:[self shownTimes] - 1];
}

- (void) hideActivityTotal {
    [self setShownTimes:1];
    [self hideActivity];
}

@end
