//
//  ListItem.m
//  testapp
//
//  Created by lichun on 2021/7/8.
//

#import "ListItem.h"

@implementation ListItem

- (void) configWithDictionary:(NSDictionary *) dictionary {
#warning 类型是否匹配
	self.category = [dictionary objectForKey:@"category"];
	self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
	self.uniqueKey = [dictionary objectForKey:@"uniquekey"];
	self.title = [dictionary objectForKey:@"title"];
	self.date = [dictionary objectForKey:@"date"];
	self.authorName = [dictionary objectForKey:@"author_name"];
	self.articleUrl = [dictionary objectForKey:@"url"];

}

@end
