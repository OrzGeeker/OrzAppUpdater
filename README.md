# OrzAppUpdater

App Updater for macOS app using Sparkle Framework


# Usage


1. Add SPM

```swift 

```


2. Setup App

```swift
import SwiftUI
import OrzAppUpdater

@main
struct OrzApp: App {
    let updaterController = OrzAppUpdaterController()
    var body: some Scene {
        WindowGroup {
            ...
        }
        .addCheckUpdatesCommand(updaterController: updaterController)
    }
}
```

3. Config App's Info.plist

add `SUFeedURL` into Info.plist, and set the value with the URL of your appcast

4. Generate appcast

5. Upload Release App

# Links

- [Sparkle](https://sparkle-project.org/)

- [Sparkle Doc](https://sparkle-project.org/documentation/)



