//
//  SystemMediator.m
//  JLRouteTest
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 GY. All rights reserved.
//

#import "SystemMediator.h"
#import "JLRoutes.h"

@interface SystemMediator ()

@property (nonatomic, strong) UINavigationController *mainNav;

@end

@implementation SystemMediator

+ (instancetype)sharedInstance {
    static SystemMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[SystemMediator alloc] init];
        [mediator registerModule];
    });
    return mediator;
}

- (void)createSystemPage {
    Class mainClass = NSClassFromString(@"MianViewController");
    Class moduleAClass = NSClassFromString(@"ModuleAMainViewController")?:NSClassFromString(@"UIViewController");
    Class moduleBClass = NSClassFromString(@"ModuleBMainViewController")?:NSClassFromString(@"UIViewController");
    
    id mainController = [[mainClass alloc] init];
    UIViewController *moduleAController = [[moduleAClass alloc] init];
    UIViewController *moduleBController = [[moduleBClass alloc] init];
    
    moduleAController.tabBarItem.title = @"业务一";
    moduleBController.tabBarItem.title = @"业务二";
    
    if ([mainController isKindOfClass:[UITabBarController class]]) {
        [mainController performSelector:@selector(setViewControllers:) withObject:@[moduleAController,moduleBController]];
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainController];
    [nav setNavigationBarHidden:YES];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = nav;
}

- (UINavigationController *)mainNav {
    if (!_mainNav) {
        _mainNav = (UINavigationController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
    }
    return _mainNav;
}

- (void)registerModule {
    [[JLRoutes globalRoutes] addRoute:@"/:moudle/:target" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *targetClassString = parameters[@"target"];
        Class targetClass = NSClassFromString(targetClassString);
        id object = [[targetClass alloc] init];
        
        if ([object isKindOfClass:[UIViewController class]]) {
            [self.mainNav pushViewController:(UIViewController *)object animated:YES];
            return YES;
        } else {
            return NO;
        }
    }];
}

- (void)openModuleWithURL:(NSURL *)url {
    if ([url.host isEqualToString:@"MouduleA"]) {
        [self openModuleAWithURL:url];
    }
}

#pragma mark moduleA
- (void)openModuleAWithURL:(NSURL *)url {
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        [[JLRoutes globalRoutes] routeURL:url];
    }];
}

- (void)openModuleB {
    
}

@end
