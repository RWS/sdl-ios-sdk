//
//  SDLExampleApp.m
//  SDL
//
//  Created by Dan Calinescu on 3/24/14.
//  Copyright (c) 2014 SDL. All rights reserved.
//

#import "SDLExampleApp.h"
#import "SDL.h"

@implementation SDLExampleApp

#pragma mark - SDL Language Cloud Examples

- (void) translateTextExample
{
    #error @"Setup your SDL Language Cloud API Key"
    // Sign up for a Free API Key here: https://languagecloud.sdl.com/translation-api/sign-up?_ref=sdl-ios-sdk
    [[SDL languageCloud] setup:@"<Insert Your SDL Language Cloud API Key Here>"];

    // Translate some text
    [[SDL languageCloud] translateText:@"Good Morning" from:[NSLocale localeWithLocaleIdentifier:@"en"] to:[NSLocale localeWithLocaleIdentifier:@"fr"] success:^(NSString* translation)
    {
        NSLog(@"Successful Translation: %@", translation);
    }
    failure:^(NSString* errorMessage)
    {
        NSLog(@"Error: %@", errorMessage);
    }];
}

- (void) runExamples
{
    [self translateTextExample];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    [self runExamples];
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
