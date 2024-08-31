# OrzAppUpdater

App Updater for macOS app using Sparkle Framework


# Usage


1. Add SPM

```swift
.package(url: "https://github.com/OrzGeeker/OrzAppUpdater.git", branch: "main")
```

2. Use SPM Product

```swift 
.product(name: "OrzAppUpdater", package: "OrzAppUpdater")
```

3. Setup App

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

4. Config App's Info.plist

- add `SUFeedURL` into Info.plist. Set the value with the URL of your appcast.xml file

- Use sparkle binary cli `generate_keys` to get your public key value. 

- add `SUPublicEDKey` into Info.plist with public key value. 

    you can use `generate_keys -x private_key`/ `generate_keys -f private_key` to export 
    or import the private key into your device local keychain. make the private_key safe

5. Generate appcast

- archive your macOS app by direct distribution with your apple developerId login

- Notarizing the archive product and export it to a directory

- use command `tar -cJf yourappname.tar.xz /path/to/yourappname.app` to create a `*.tar.xz` zip of your `.app` bundle

- use sparkle cli `generate_appcast /dir_path/of/yourappname.tar.xz` to generate the appcast.xml file

- upload the `yourappname.tar.xz`, and get an url

- change your appcase.xml content for tag `<enclosure url="https://xxx/yourappname.tar.xz"`, make the url prop equal the uploaded app.tar.xz's url

- upload the appcase.xml to the location of `SUFeedURL`'s value specified

# Links

- [Sparkle](https://sparkle-project.org/)

- [Sparkle Doc](https://sparkle-project.org/documentation/)
