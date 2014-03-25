//
//  LanguageCloudTests.m
//
//  Created by Dan Calinescu on 3/24/14.
//  Copyright (c) 2014 SDL. All rights reserved.
//

#import <XCTest/XCTest.h>

#define EXP_SHORTHAND YES

#import "Specta.h"
#import "Expecta.h"
#import "OCMock.h"
#import "Nocilla.h"

#import "LanguageCloud.h"
#import "LanguageCloudOperation.h"

#define TEST_NAME_GOOD_MORNING_EN_TO_FR                 @"can translate 'good morning' from english to french"
#define TEST_JSON_RESPONSE_FILE_GOOD_MORNING_EN_TO_FR   @"good-morning-from-en-to-fr"

SpecBegin(SDLLanguageCloud)

describe(@"Translation Operations", ^{
    
    __block id _blockSuccess            =   nil;
    __block id _blockError              =   nil;
    __block NSOperationQueue* _queue    =   nil;
    __block NSBundle* _bundle           =   nil;
    
    beforeAll(^{
        _queue           = [[NSOperationQueue alloc] init];
        _bundle          = [NSBundle bundleForClass:[self class]];
        
        [[LSNocilla sharedInstance] start];
        [Expecta setAsynchronousTestTimeout:5.0];
    });
    
    beforeEach(^{
        _blockError      = nil;
        _blockSuccess    = nil;
    });
    
    it (TEST_NAME_GOOD_MORNING_EN_TO_FR, ^AsyncBlock {

        // Expected JSON response
        NSString* expectedJsonResponse = [NSString stringWithContentsOfFile:[_bundle pathForResource:TEST_JSON_RESPONSE_FILE_GOOD_MORNING_EN_TO_FR ofType:@"json"] encoding:NSUTF8StringEncoding error:NULL];

        // Don't actually make the request, stub it
        stubRequest(@"POST", [[LanguageCloud baseUrl] stringByAppendingString:@"translate"]).andReturn(200).
        withHeaders(@{@"Content-Type": @"application/json"}).
        withBody (expectedJsonResponse);

        // Setup the operation
        LanguageCloudOperation* operation = [LanguageCloudOperation translateTextOperation:@"" from:[NSLocale localeWithLocaleIdentifier:@"en"] to:[NSLocale localeWithLocaleIdentifier:@"fr"] text:@"good morning"];
        
        // Response logic
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            _blockSuccess = responseObject;
            dispatch_async(dispatch_get_main_queue(), ^{
                expect(_blockSuccess).willNot.beNil();
                NSString* translation = [responseObject objectForKey:@"translation"];
                expect(translation).willNot.beNil();
                expect([translation lowercaseString]).to.equal (@"bonjour");
            });
            done ();
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            _blockError = error;
            dispatch_async(dispatch_get_main_queue(), ^{
                expect(_blockError).will.beNil();
            });
            done ();
        }];

        // Let's make the request
        [_queue addOperation:operation];
    });
    
});

SpecEnd