//
//  XHItemScrollToolBar.m
//  XHCartoon
//
//  Created by 曾 宪华 on 14-1-23.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHItemScrollToolBar.h"

@interface XHItemScrollToolBar ()

@property (nonatomic, strong) NSArray *itemViews;

@end

@implementation XHItemScrollToolBar

- (NSArray *)itemViews {
    if (!_itemViews) {
        _itemViews = [[NSArray alloc] init];
    }
    return _itemViews;
}

- (void)setItems:(NSArray *)items {
    if (!items)
        return;
    _items = items;
}

- (void)reloadData {
    [self _layoutSubviews];
}

- (void)_layoutSubviews {
    NSMutableArray *itemVies = [[NSMutableArray alloc] initWithCapacity:5];
    for (XHItem *item in self.items) {
        NSInteger index = [self.items indexOfObject:item];
        item.index = index;
        CGRect bottomItemFrame = CGRectMake(index * (self.itemWidth + self.itemPaddingX) + self.itemPaddingX, self.itemPaddingY, self.itemWidth, CGRectGetHeight(self.bounds) - self.itemPaddingY * 2);
        XHItemView *itemView = [[XHItemView alloc] initWithFrame:bottomItemFrame item:item];
        if (index == self.selectIndex) {
            itemView.selected = YES;
        }
        [itemView addTarget:self action:@selector(itemViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        itemView.frame = bottomItemFrame;
        [self addSubview:itemView];
        [itemVies addObject:itemView];
    }
    self.itemViews = itemVies;
    
    [self _setupContentSize];
}

- (void)_setupContentSize {
    self.contentSize = CGSizeMake((self.itemWidth + self.itemPaddingX) * self.items.count + self.itemPaddingX, 0);
}

- (void)itemViewClicked:(XHItemView *)itemView {
    if (itemView.item.itemSelectedCompled) {
        itemView.item.itemSelectedCompled(itemView);
    }
    if (itemView.item.unHieghtSelect)
        return;
    for (XHItemView *_itemView in self.itemViews) {
        if (itemView == _itemView) {
            if (!itemView.item.unHieghtSelect) {
                _itemView.selected = YES;
            }
        } else {
            _itemView.selected = NO;
        }
    }
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
