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

#import "UIView+AGAdditions.h"

@implementation UIView (AGAdditions)

#pragma mark - nib
+ (UINib*) nib {
    return [UINib nibWithNibName:NSStringFromClass(self)
                          bundle:nil];
}

+ (NSArray*) loadNib {
    return [self loadNibWithOwner:nil];
}
+ (NSArray*) loadNibWithOwner:(id)owner {
    return [[self nib] instantiateWithOwner:owner options:nil];
}

+ (instancetype) viewFromNib {
    return [self viewFromNibWithOwner:nil];
}
+ (instancetype) viewFromNibWithOwner:(id)owner {
    return [[self loadNibWithOwner:owner] firstObject];
}

#pragma mark - content hugging
- (void) sizeToHugContent {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = self.frame;
    
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - container view
- (void) useAsContainerForView:(UIView*)contentView {
    [self useAsContainerForView:contentView
                 usingTopLayout:nil
                   bottomLayout:nil];
}

- (void) useAsContainerForView:(UIView*)contentView
                usingTopLayout:(id<UILayoutSupport>)topLayout
                  bottomLayout:(id<UILayoutSupport>)bottomLayout {
    
    for (UIView* subview in self.subviews) {
        if ([subview conformsToProtocol:@protocol(UILayoutSupport)] == NO) {
            [subview removeFromSuperview];
        }
    }
    
    [self addSubview:contentView
    withTopNeighbour:topLayout
         topDistance:nil
     bottomNeighbour:bottomLayout
      bottomDistance:nil
    leadingNeighbour:nil
     leadingDistance:nil
   trailingNeighbour:nil
    trailingDistance:nil];
}

#pragma mark - addSubview
- (void) addSubview:(UIView *)view
   withTopNeighbour:(id)topNeighbour
        topDistance:(NSNumber*)topDistance
    bottomNeighbour:(id)bottomNeighbour
     bottomDistance:(NSNumber*)bottomDistance
   leadingNeighbour:(id)leadingNeighbour
    leadingDistance:(NSNumber*)leadingDistance
  trailingNeighbour:(id)trailingNeighbour
   trailingDistance:(NSNumber*)trailingDistance {
   
    NSMutableDictionary* dictViews = [NSMutableDictionary new];
    dictViews[@"subview"] = view;
    if (topNeighbour) {
        dictViews[@"top"] = topNeighbour;
    }
    if (bottomNeighbour) {
        dictViews[@"bottom"] = bottomNeighbour;
    }
    if (leadingNeighbour) {
        dictViews[@"leading"] = leadingNeighbour;
    }
    if (trailingNeighbour) {
        dictViews[@"trailing"] = trailingNeighbour;
    }
    
    NSMutableDictionary* dictMetrics = [NSMutableDictionary new];
    if (topDistance) {
        dictMetrics[@"distTop"] = topDistance;
    }
    if (bottomDistance) {
        dictMetrics[@"distBottom"] = bottomDistance;
    }
    if (leadingDistance) {
        dictMetrics[@"distLeading"] = leadingDistance;
    }
    if (trailingDistance) {
        dictMetrics[@"distTrailing"] = trailingDistance;
    }
    
    NSMutableArray* layoutInfo = [NSMutableArray new];
    [layoutInfo addObject:@{kUIViewAGAdditionsConstraintVisualFormat:  [NSString stringWithFormat:@"V:%@%@[subview]%@%@",
                                                                        topNeighbour ? @"[top]": @"|",
                                                                        topDistance ? @"-distTop-": @"",
                                                                        bottomNeighbour ? @"[bottom]" : @"|",
                                                                        bottomDistance ? @"-distBottom-": @""],
                             kUIViewAGAdditionsConstraintMetrics:       dictMetrics,
                             kUIViewAGAdditionsConstraintViews:         dictViews}];
    [layoutInfo addObject:@{kUIViewAGAdditionsConstraintVisualFormat:  [NSString stringWithFormat:@"H:%@%@[subview]%@%@",
                                                                        leadingNeighbour ? @"[leading]": @"|",
                                                                        leadingDistance ? @"-distLeading-": @"",
                                                                        trailingNeighbour ? @"[trailing]" : @"|",
                                                                        trailingDistance ? @"-distTrailing-": @""],
                             kUIViewAGAdditionsConstraintMetrics:       dictMetrics,
                             kUIViewAGAdditionsConstraintViews:         dictViews}];
    [self addSubview:view
      withLayoutInfo:layoutInfo];
}

- (void) addSubview:(UIView *)view
     withLayoutInfo:(NSArray*)layoutInfo {
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    for (NSDictionary* constraintsDict in layoutInfo) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraintsDict[kUIViewAGAdditionsConstraintVisualFormat]
                                                                     options:[constraintsDict[kUIViewAGAdditionsConstraintOptions] integerValue]
                                                                     metrics:constraintsDict[kUIViewAGAdditionsConstraintMetrics]
                                                                       views:constraintsDict[kUIViewAGAdditionsConstraintViews]]];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
