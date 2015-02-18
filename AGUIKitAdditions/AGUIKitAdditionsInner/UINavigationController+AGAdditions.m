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

#import "UINavigationController+AGAdditions.h"

@implementation UINavigationController (AGAdditions)

+ (UIBarButtonItem*) navBarItemWithTitle:(NSString*)title
                              titleColor:(UIColor*)titleColor
                   titleColorHighlighted:(UIColor*)titleColorHighlighted
                                  target:(id)target
                                  action:(SEL)action {
    
    return [self navBarItemWithImage:nil
                    imageHighlighted:nil
                               title:title
                          titleColor:titleColor
               titleColorHighlighted:titleColorHighlighted
                              target:target
                              action:action];
}


+ (UIBarButtonItem*) navBarItemWithImage:(UIImage*)image
                        imageHighlighted:(UIImage*)imageHighlighted
                                  target:(id)target
                                  action:(SEL)action {
    
    return [self navBarItemWithImage:image
                    imageHighlighted:imageHighlighted
                               title:nil
                          titleColor:nil
               titleColorHighlighted:nil
                              target:target
                              action:action];
}


+ (UIBarButtonItem*) navBarItemWithImage:(UIImage*)image
                        imageHighlighted:(UIImage*)imageHighlighted
                                   title:(NSString*)title
                              titleColor:(UIColor*)titleColor
                   titleColorHighlighted:(UIColor*)titleColorHighlighted
                                  target:(id)target
                                  action:(SEL)action {
    
    UIButton* bn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (titleColor) {
        [bn setTitleColor:titleColor
                 forState:UIControlStateNormal];
    }
    if (titleColorHighlighted) {
        [bn setTitleColor:titleColorHighlighted
                 forState:UIControlStateHighlighted];
    }
    
    if (title.length) {
        [bn setTitle:title
            forState:UIControlStateNormal];
    }
    
    if (image) {
        [bn setImage:image
            forState:UIControlStateNormal];
    }
    if (imageHighlighted) {
        [bn setImage:imageHighlighted
            forState:UIControlStateHighlighted];
    }
    
    if (target && action) {
        [bn addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    }
    
    [bn sizeToFit];
    CGRect frame = bn.frame;
    if (frame.size.height < 44) {
        frame.size.height = 44;
    }
    if (frame.size.width < 44) {
        frame.size.width = 44;
    }
    bn.frame = frame;
    
    return [[UIBarButtonItem alloc] initWithCustomView:bn];
}

+ (UIBarButtonItem*) navBarItemSpaceWithWidth:(CGFloat)width {
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:nil
                                                                          action:nil];
    item.width = width;
    return item;
}

@end
