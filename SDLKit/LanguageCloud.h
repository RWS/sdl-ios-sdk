//
//  LanguageCloud.h
//  
//
//  Created by Dan Calinescu on 3/25/14.
//
//

#import <Foundation/Foundation.h>

@interface LanguageCloud : NSObject

+ (NSString*) baseUrl;
+ (NSDictionary*) supportedLanguages;

- (void) setup: (NSString*) apiKey;

- (void) translateText: (NSString*) text from: (NSLocale*) from to: (NSLocale*) to success: (void (^) (NSString* translatedText)) success failure: (void (^)(NSString* errorMessage)) failure;

@end
