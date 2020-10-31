# appkit-in-catalyst
Demo for an article.
https://philzet.medium.com/mac-catalyst-interfacing-between-uikit-and-appkit-without-private-apis-in-swift-5d6b90dab08d

Mac Catalyst is a great opportunity for iOS developers to bring their existing offerings to the Mac with minimal modification. However, once you dig deeper into what you can and can’t do, you’ll realize that you’re restricted to a small subset of functionality that Mac has to offer.
Image for post
I will share my method of using both UIKit and AppKit in a single Catalyst application to provide the native experience. All of this works in both macOS Catalina and macOS Big Sur. A word of caution: you’re just getting started with a new macOS project, my advice is to go with either AppKit or SwiftUI. They offer the native experience out of the box and are likely to be better documented. If your goal is to create a complex application that utilizes lots of native macOS features, definitely go with AppKit. The method I’m presenting here is primarily for developers who either a) have an existing Catalyst app, b) an iOS app they want to port to the Mac, or c) who have large iOS codebases.
In this article, I will discuss:
how Catalyst interfaces between UIKit and AppKit;
how we can call AppKit APIs from our Catalyst (UIKit) app;
how we can add native Mac UI elements (and more) to the UIKit view hierarchy.
