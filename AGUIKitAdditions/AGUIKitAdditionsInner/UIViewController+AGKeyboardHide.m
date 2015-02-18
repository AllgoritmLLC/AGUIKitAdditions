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

#import "UIViewController+AGKeyboardHide.h"

#import <objc/runtime.h>

@implementation UIViewController(AGKeyboardHide)

#pragma mark - associated objects
- (BOOL) hideKeyboardOnTap {
    return [objc_getAssociatedObject(self, @selector(hideKeyboardOnTap)) boolValue];
}

- (void) setHideKeyboardOnTap:(BOOL) aHideKeyboardOnTap{
    objc_setAssociatedObject(self, @selector(hideKeyboardOnTap), @(aHideKeyboardOnTap), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    if (aHideKeyboardOnTap) {
        [center addObserver:self
                   selector:@selector(showOverlay:)
                       name:UIKeyboardDidShowNotification
                     object:nil];
    }else{
        [center removeObserver:self
                          name:UIKeyboardDidShowNotification
                        object:nil];
    }
    
}

- (UIView *) vOverlay {
    UIView *overlay = objc_getAssociatedObject(self, @selector(vOverlay));
    if (!overlay) {
        overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        overlay.translatesAutoresizingMaskIntoConstraints = NO;
        overlay.hidden = YES;
        overlay.backgroundColor = [UIColor clearColor];
        
        UIView* parentView;
        
        if(self.navigationController){
            parentView = self.navigationController.view;
        }else{
            parentView = self.view;
        }
        
        [parentView addSubview:overlay];
        NSDictionary *viewsDict = @{@"overlay": overlay};
        [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[overlay]-0-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:viewsDict]];
        
        [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[overlay]-0-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDict]];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(hideKeyboard:)];
        [overlay addGestureRecognizer:tapGestureRecognizer];
        
        objc_setAssociatedObject(self, @selector(vOverlay), overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return overlay;
}

- (void) hideKeyboard: (UITapGestureRecognizer *)sender {
    [self vOverlay].hidden = YES;
    [self.view endEditing:YES];
}

- (void) showOverlay: (NSNotification *) notification{
    [self vOverlay].hidden = NO;
}


@end
