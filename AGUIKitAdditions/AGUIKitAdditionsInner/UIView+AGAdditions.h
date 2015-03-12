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

#import <UIKit/UIKit.h>

@interface UIView (AGAdditions)

#pragma mark - nib
+ (UINib*) nib;

+ (NSArray*) loadNib;
+ (NSArray*) loadNibWithOwner:(id)owner;

+ (instancetype) viewFromNib;
+ (instancetype) viewFromNibWithOwner:(id)owner;

#pragma mark - content hugging
- (void) sizeToHugContent;

#pragma mark - container view
- (void) useAsContainerForView:(UIView*)contentView;
- (void) useAsContainerForView:(UIView*)contentView
                usingTopLayout:(id<UILayoutSupport>)topLayout
                  bottomLayout:(id<UILayoutSupport>)bottomLayout;

#pragma mark - addSubview
- (void) addSubview:(UIView *)view
   withTopNeighbour:(id)topNeighbour
        topDistance:(NSNumber*)topDistance
    bottomNeighbour:(id)bottomNeighbour
     bottomDistance:(NSNumber*)bottomDistance
   leadingNeighbour:(id)leadingNeighbour
    leadingDistance:(NSNumber*)leadingDistance
  trailingNeighbour:(id)trailingNeighbour
   trailingDistance:(NSNumber*)trailingDistance;
    
#define kUIViewAGAdditionsConstraintVisualFormat    @"kUIViewAGAdditionsConstraintVisualFormat"
#define kUIViewAGAdditionsConstraintOptions         @"kUIViewAGAdditionsConstraintOptions"
#define kUIViewAGAdditionsConstraintMetrics         @"kUIViewAGAdditionsConstraintMetrics"
#define kUIViewAGAdditionsConstraintViews           @"kUIViewAGAdditionsConstraintViews"
- (void) addSubview:(UIView *)view
     withLayoutInfo:(NSArray*)layoutInfo;

@end
