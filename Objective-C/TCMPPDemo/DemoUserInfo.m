//
//  DemoUserInfo.m
//  TCMPPDemo
//
//  Created by stonelshi on 2023/5/5.
//  Copyright (c) 2023 Tencent. All rights reserved.
//

#import "DemoUserInfo.h"

#define DEV_LOGIN_NAME @"dev_login_name"

@implementation DemoUserInfo


+ (instancetype)sharedInstance {
    static DemoUserInfo* manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DemoUserInfo alloc] init];
        [manager readLoginInfo];
    });
    return manager;
}


- (void)readLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSString *username = [userDefaults objectForKey:DEV_LOGIN_NAME];
    if(username && username.length>0) {
        self.nickName = username;
    } else {
        self.nickName = @"unknown";
    }
//    else {
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"HHmmss"];
//        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
//        self.nickName = [NSString stringWithFormat:@"user%@",currentDateStr];
//        [self writeInfoFile:self.nickName];
//    }
    
    //example code
    self.avatarUrl = @"https://upload.shejihz.com/2019/04/25704c14def5257a157f2d0f4b7ae581.jpg";
    self.country = @"China";
    self.province = @"Beijing";
    self.gender = UserGenderTypeMale;
    self.city = @"Chaoyang";
}

- (void)setNickName:(NSString *)nickName {
    _nickName = nickName;
    if (nickName) {
        [self writeInfoFile:nickName];
    } else {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:DEV_LOGIN_NAME];
    }
    
}

- (void)writeInfoFile:(NSString *)username {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setObject:username forKey:DEV_LOGIN_NAME];
}

@end
