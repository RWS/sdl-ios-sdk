//
//  LanguageCloudOperation.m
//  SDL
//
//  Created by Dan Calinescu on 3/25/14.
//  Copyright (c) 2014 SDL. All rights reserved.
//

#import "LanguageCloudOperation.h"
#import "LanguageCloud.h"
#import "AFNetworking.h"


@interface LanguageCloudOperation()
{
}
@end

@implementation LanguageCloudOperation

+ (LanguageCloudOperation*) jsonSecureOperationWithKeyMethodEndpointAndParams: (NSString*) key method: (NSString*) method endpoint: (NSString*) endpoint params: (NSDictionary*) params
{
    NSError* error;
    NSMutableURLRequest* request = [[AFJSONRequestSerializer serializer] requestWithMethod:[method uppercaseString] URLString:[[LanguageCloud baseUrl] stringByAppendingString:endpoint] parameters:params error:&error];
    [request setValue:[NSString stringWithFormat:@"BeGlobal apiKey=%@", key] forHTTPHeaderField:@"Authorization"];
    LanguageCloudOperation* operation = [[LanguageCloudOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    return operation;
}

+ (LanguageCloudOperation*) translateTextOperation: (NSString*) key from: (NSLocale*) from to: (NSLocale*) to text: (NSString*) text
{
    NSString* fromLanguage = [[LanguageCloud supportedLanguages] objectForKey:[from objectForKey:NSLocaleLanguageCode]];
    NSString* toLanguage = [[LanguageCloud supportedLanguages] objectForKey:[to objectForKey:NSLocaleLanguageCode]];
    
    if (fromLanguage == nil || toLanguage == nil)
    {
        return nil;
    }
    
    return [LanguageCloudOperation jsonSecureOperationWithKeyMethodEndpointAndParams:key method:@"POST" endpoint:@"translate" params:@{@"from": fromLanguage, @"to" : toLanguage, @"text" : text}];
}

- (id) initWithRequest:(NSURLRequest *) request
{
    self = [super initWithRequest:request];
    if (self)
    {
    }
    return self;
}

@end
