//
//  SDL.m
//  
//
//  Created by Dan Calinescu on 3/24/14.
//
//

#import "SDL.h"

@implementation SDL

+ (LanguageCloud*) languageCloud
{
    static LanguageCloud* instance = nil;
    static dispatch_once_t token;
    dispatch_once (&token, ^{
        instance = [[LanguageCloud alloc] init];
    });
    
    return instance;
}

@end
