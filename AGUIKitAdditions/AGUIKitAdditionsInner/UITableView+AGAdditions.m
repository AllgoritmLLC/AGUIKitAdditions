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

#import "UITableView+AGAdditions.h"

#import "UIView+AGAdditions.h"

@implementation UITableView (AGAdditions)

- (void) removeEmptyCells {
    UIView* fakeFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    fakeFooter.backgroundColor = [UIColor clearColor];
    self.tableFooterView = fakeFooter;
}

- (void) sizeTableHeaderViewToFit {
    UIView* view = self.tableHeaderView;
    [view sizeToHugContent];
    self.tableHeaderView = view;
}

- (void) removeHeaderOffsetForGrouppedStyle {
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.tableHeaderView.backgroundColor = [UIColor clearColor];
}

@end
