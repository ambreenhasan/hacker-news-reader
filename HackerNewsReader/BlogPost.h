//
//  BlogPost.h
//  HackerNewsReader
//
//  Created by Ambreen Hasan on 4/1/15.
//  Copyright (c) 2015 Ambreen Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogPost : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSURL *url;


// Designated header file
- (id) initWithTitle:(NSString *)title;
+ (id) blogPostWithTitle:(NSString *)title;

- (NSURL *) thumbnailURL;

- (NSString *) formattedDate;

- (NSString *) daysAgo;

- (NSString *) unixTimestampConverter;

@end