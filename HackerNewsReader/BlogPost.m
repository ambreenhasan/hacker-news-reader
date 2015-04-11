//
//  BlogPost.m
//  HackerNewsReader
//
//  Created by Ambreen Hasan on 4/1/15.
//  Copyright (c) 2015 Ambreen Hasan. All rights reserved.
//

#import "BlogPost.h"

@implementation BlogPost

-(id) initWithTitle:(NSString *)title {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.author = nil;
        self.thumbnail = nil;
    }
    
    return self;
}

+ (id) blogPostWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}


- (NSURL *) thumbnailURL {
    return [NSURL URLWithString:self.thumbnail];
}

- (NSString *) formattedDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *tempDate = [dateFormatter dateFromString:self.date];
    
    [dateFormatter setDateFormat:@"EE MMM, dd"];
    
    return [dateFormatter stringFromDate:tempDate];
}

- (NSString *) daysAgo {
    double min = 60;
    double hour = min * 60;
    double day = hour * 24;
    double week = day * 7;
    double month = week * 4;
    double year = month * 12;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate = [dateFormatter dateFromString:self.date];
    
    NSDate *today = [NSDate date];
    double timeAgo = fabs([tempDate timeIntervalSinceDate:today]); // absolute value
    
    NSString *timeAgoString;
    
    if (timeAgo < min) {
        timeAgoString = [NSString stringWithFormat:@"%f seconds ago", timeAgo];
    } else if (timeAgo < hour) {
        timeAgoString = [NSString stringWithFormat:@"%d minutes ago",(int)(timeAgo/min)];
    } else if (timeAgo < day) {
        timeAgoString = [NSString stringWithFormat:@"%d hours ago", (int)(timeAgo/hour)];
    } else if (timeAgo < week) {
        timeAgoString = [NSString stringWithFormat:@"%d days ago", (int)(timeAgo/day)];
    } else if (timeAgo < month) {
        timeAgoString = [NSString stringWithFormat:@"%d weeks ago", (int)(timeAgo/week)];
    } else if (timeAgo < year) {
        timeAgoString = [NSString stringWithFormat:@"%d months ago", (int)(timeAgo/month)];
    } else {
        timeAgoString = [NSString stringWithFormat:@"%d years ago", (int)(timeAgo/year)];
    }
    
    return timeAgoString;
    
}

- (NSString *) unixTimestampConverter {
    double min = 60;
    double hour = min * 60;
    double day = hour * 24;
    double week = day * 7;
    double month = week * 4;
    double year = month * 12;
    NSString *timeAgoString;
    
    NSTimeInterval _interval=[self.date doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSLog(@"%@", date);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *today = [NSDate date];
    double timeAgo = fabs([date timeIntervalSinceDate:today]); // absolute value
    
    
    if (timeAgo < min) {
        timeAgoString = [NSString stringWithFormat:@"%f seconds ago", timeAgo];
    } else if (timeAgo < hour) {
        timeAgoString = [NSString stringWithFormat:@"%d minutes ago",(int)(timeAgo/min)];
    } else if (timeAgo < day) {
        timeAgoString = [NSString stringWithFormat:@"%d hours ago", (int)(timeAgo/hour)];
    } else if (timeAgo < week) {
        timeAgoString = [NSString stringWithFormat:@"%d days ago", (int)(timeAgo/day)];
    } else if (timeAgo < month) {
        timeAgoString = [NSString stringWithFormat:@"%d weeks ago", (int)(timeAgo/week)];
    } else if (timeAgo < year) {
        timeAgoString = [NSString stringWithFormat:@"%d months ago", (int)(timeAgo/month)];
    } else {
        timeAgoString = [NSString stringWithFormat:@"%d years ago", (int)(timeAgo/year)];
    }

    
    return timeAgoString;
}


@end
