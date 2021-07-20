//
//  HoverViewFlowLayout.m
//  testapp
//
//  Created by lichun on 2021/7/20.
//

#import "HoverViewFlowLayout.h"

@implementation HoverViewFlowLayout

- (instancetype) initWithTopHeight: (CGFloat) height {
    self = [super init];
    if (self) {
        self.topHeight = height;
    }
    return self;
}

- (NSArray *) layoutAttributesForElementsInRect: (CGRect) rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attributes in [superArray mutableCopy]) {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [superArray removeObject:attributes];
        }
    }
    
    [superArray addObject:[super initialLayoutAttributesForAppearingSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]];
    
    for (UICollectionViewLayoutAttributes *attributes in superArray) {
        if (attributes.indexPath.section == 0) {
            if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                CGRect rect = attributes.frame;
                if (self.collectionView.contentOffset.y + self.topHeight - rect.size.height > rect.origin.y) {
                    rect.origin.y = self.collectionView.contentOffset.y + self.topHeight - rect.size.height;
                    attributes.frame = rect;
                }
                // 有较高索引值的项目出现在具有较低值的项目之上
                attributes.zIndex = 5;
            }
        }
    }
    return [superArray copy];
}

// 应该使边界更改的布局无效
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
