## SDL iOS SDK

The SDL iOS SDK provides an easy to use interface to the SDL Language Cloud.
This SDK allows you to embed machine and human translation directly into
your iOS app.

### Getting Started

#### Get Your SDL Language Cloud API Key

- [Sign Up Here] (https://languagecloud.sdl.com/translation-api/sign-up) to get a Free API Key

#### Run the Sample app

- Open the SDL.xcworkspace
- Run the SDLExampleApp application
- You should be getting and error that prompts you to setup your API key 
- Setup your key in the SDLExampleApp.m file
- Run the Sample app and you should now see a successful translation in your Console view
```ruby
2014-03-25 20:31:57.568 SDL[47320:a0b] Translation: Bonjour
```
- Congrats, you just performed your first translation!

### Add the SDL SDK to your iOS app

#### Add via CocoaPods
```ruby
platform :ios, '7.0'
pod "SDL-iOS-SDK", "~> 0.1.0"
```

####  Import the SDK into your code

```ruby
#import "SDL.h"
```

#### Setup your API Key once

```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[SDL languageCloud] setup:@"<your api key>"]
   ...
}
```

#### Perform a text translation

```ruby
 [[SDL languageCloud] translateText:@"Good Morning" from:[NSLocale localeWithLocaleIdentifier:@"en"] to:[NSLocale localeWithLocaleIdentifier:@"fr"] success:^(NSString* translation)
    {
        NSLog(@"Successful Translation: %@", translation);
    }
    failure:^(NSString* errorMessage)
    {
        NSLog(@"Error: %@", errorMessage);
    }
];
```

### License

The SDL iOS SDK is made available under the MIT license. Pleace see the LICENSE file 
for more details.
