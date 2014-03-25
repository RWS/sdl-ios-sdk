//
//  LanguageCloud.m
//  
//
//  Created by Dan Calinescu on 3/25/14.
//
//

#import "LanguageCloud.h"
#import "LanguageCloudOperation.h"
#import "SDL.h"

#define BASE_API_URL @"https://lc-api.sdl.com/"

@interface LanguageCloud ()
{
    NSString*       _apiKey;
    NSDictionary*   _supportedLanguages;
}
@end

@implementation LanguageCloud

+ (NSString*) baseUrl
{
    return BASE_API_URL;
}

+ (NSDictionary*) supportedLanguages
{
    static NSDictionary* languages = nil;
    static dispatch_once_t token;
    dispatch_once (&token, ^{
        languages = @{
                      @"en": @"eng", //English
                      @"fr": @"fra", //French
                      @"it": @"ita", //Italian
                      @"de": @"ger", //German
                      @"es": @"spa", //Spanish
                      @"pt": @"por", //Portuguese
                      @"ru": @"rus", //Russian
                      @"ro": @"rum", //Romanian
                      @"zh-Hans": @"chi", //Simplified
                      @"zh-Hant": @"cht", //Traditional
                      @"ja": @"jpn", //Japanese
                      @"ar": @"ara", //Arabic
                      @"el": @"gre", //Greek
                      @"pl": @"pol", //Polish
                      @"cs": @"cze", //Czech
                      @"nl": @"dut", //Dutch
                      @"th": @"tha", //Thai
                      @"sk": @"slo", //Slovakian
                      @"nb": @"nor", //Norwegian
                      @"fi": @"fin", //Finnish
                      @"id": @"ind", //Indonesian
                      @"sl": @"slv", //Slovenian
                      @"hu": @"hun", //Hungarian
                      @"ko": @"kor", //Korean
                      @"da": @"dan", //Danish
                      @"ha": @"hau", //Hausa
                      @"ur": @"urd", //Urdu
                      @"he": @"heb", //Hebrew
                      @"fa": @"per", //Persian
                      @"sv": @"swe", //Swedish
                      @"bg": @"bul", //Bulgarian
                      @"sr": @"srp", //Serbian
                      @"ps": @"pus", //Pashto
                      @"so": @"som", //Somali
                      @"fa-af": @"fad", //Dari
                      @"bn": @"ben", //Bengali
                      @"et": @"est", //Estonian
                      @"lt": @"lit", //Lithuanian
                      @"uk": @"ukr", //Ukranian
                      @"ms": @"may", //Malay
                      @"hi": @"hin", //Hindi
                      @"vi": @"vie", //Vietnamese
                      @"tr": @"tur"  //Turkish
                      };
    });
    return languages;
}

- (id) init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void) setup: (NSString*) apiKey
{
    _apiKey = [apiKey copy];
}

- (void) translateText: (NSString*) text from: (NSLocale*) from to: (NSLocale*) to success: (void (^) (NSString* translatedText)) success failure: (void (^)(NSString* errorMessage)) failure
{
    if (_apiKey == nil)
    {
        failure (@"Missing API Key");
        return;
    }
    
    // Setup the operation
    LanguageCloudOperation* operation = [LanguageCloudOperation translateTextOperation:_apiKey from:from to:to text:text];
    
    // Response logic
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if (responseObject == nil)
        {
            // Let's make sure we have a valid response
            failure (@"Invalid response");
            return;
        }
        
        success ([responseObject objectForKey:@"translation"]);
    }
    
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        failure ([error localizedDescription]);
    }];
    
    // Let's dispatch the request
    [[NSOperationQueue mainQueue] addOperation:operation];
}

@end
