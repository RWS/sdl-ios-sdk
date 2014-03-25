//
//  LanguageCloudOperation.h
//  SDL
//
//  Created by Dan Calinescu on 3/25/14.
//  Copyright (c) 2014 SDL. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

@interface LanguageCloudOperation : AFHTTPRequestOperation

+ (LanguageCloudOperation*) translateTextOperation: (NSString*) key from: (NSLocale*) from to: (NSLocale*) to text: (NSString*) text;

+ (LanguageCloudOperation*) jsonSecureOperationWithKeyMethodEndpointAndParams: (NSString*) key method: (NSString*) method endpoint: (NSString*) endpoint params: (NSDictionary*) params;

@end
