//
//  NotificationManager.m
//  Bird
//
//  Created by MacCoder on 2/10/14.
//  Copyright (c) 2014 MacCoder. All rights reserved.
//

#import "NotificationManager.h"
#import "Utils.h"

@implementation NotificationManager

+ (NotificationManager *)instance {
    static NotificationManager *instance = nil;
    if (!instance) {
        instance = [[NotificationManager alloc] init];
    }
    return instance;
}

- (void)registerNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSArray *dates = [self notificationDates];
    NSArray *bodyTexts = [self notificationBodyTexts];
    NSArray *actionTexts = [self notificationActionTexts];

    for (int i = 0; i < dates.count; i++) {
        [self registerLocalNotification:[[dates objectAtIndex:i] intValue]
                               bodyText:[bodyTexts randomObject]
                             actionText:[actionTexts randomObject]];
    }
}

- (NSArray *)notificationDates {
    int min = 60;
    int hour = 60 * min;
    int day = 24 * hour;
    int week = 7 * day;
    int month = 30 * day;
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
            @(1 * hour),
            @(2 * hour),
            @(4 * hour),
            @(8 * hour),
            @(12 * hour),
            @(1 * day),
            @(2 * day),
            @(3 * day),
            @(1 * week),
            @(2 * week),
            @(3 * week),
            @(1 * month),
            nil];
    
    for (int i = 1; i < 12; i++) {
        [array addObject:@((i * month) + (1 * week))];
        [array addObject:@((i * month) + (2 * week))];
        [array addObject:@((i * month) + (3 * week))];
        [array addObject:@((i + 1) * month)];
    }
    return [NSArray arrayWithArray:array];
}

- (NSArray *)notificationBodyTexts{
    return [NSArray arrayWithObjects:
            @"Ready to reach new height?",
            @"How far can you go?",
            nil];
}

- (NSArray *)notificationActionTexts {
    return [NSArray arrayWithObjects:
            @"Let's go!",
            nil];
}

- (void)registerLocalNotification:(NSTimeInterval)sec bodyText:(NSString *)bodyText actionText:(NSString *)actionText{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:sec];
    localNotification.alertBody = bodyText;
    localNotification.alertAction = actionText;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
