//
//  ListItem.m
//  testapp
//
//  Created by lichun on 2021/7/8.
//

#import "ListItem.h"

@implementation ListItem

#pragma mark - NSScureCoding

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self) {
		self.category = [coder decodeObjectForKey:@"category"];
		self.picUrl = [coder decodeObjectForKey:@"picUrl"];
		self.uniqueKey = [coder decodeObjectForKey:@"uniqueKey"];
		self.title = [coder decodeObjectForKey:@"title"];
		self.date = [coder decodeObjectForKey:@"date"];
		self.authorName = [coder decodeObjectForKey:@"authorName"];
		self.articleUrl = [coder decodeObjectForKey:@"articleUrl"];
	}
	return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.category forKey:@"category"];
	[coder encodeObject:self.picUrl forKey:@"picUrl"];
	[coder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
	[coder encodeObject:self.title forKey:@"title"];
	[coder encodeObject:self.date forKey:@"date"];
	[coder encodeObject:self.authorName forKey:@"authorName"];
	[coder encodeObject:self.articleUrl forKey:@"articleUrl"];
}

+(BOOL) supportsSecureCoding {
	return YES;
}

#pragma mark - public method

- (void) configWithDictionary:(NSDictionary *) dictionary {
#warning 类型是否匹配
	self.category = [dictionary objectForKey:@"category"];
	self.picUrl = [dictionary objectForKey:@"picUrl"];
	self.uniqueKey = [dictionary objectForKey:@"uniqueKey"];
	self.title = [dictionary objectForKey:@"title"];
	self.date = [dictionary objectForKey:@"date"];
	self.authorName = [dictionary objectForKey:@"authorName"];
	self.articleUrl = [dictionary objectForKey:@"articleUrl"];

}

@end
