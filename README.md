# OrzAppUpdater

基于 Sparkle 的 macOS 应用更新封装，面向 SwiftUI，提供“检查更新…”菜单项与配置诊断能力。

## 环境要求

- macOS 11+
- Swift 5.10 / Xcode 15+
- Sparkle 2.9.0

## 安装

```swift
.package(url: "https://github.com/OrzGeeker/OrzAppUpdater.git", branch: "main")
```

```swift
.product(name: "OrzAppUpdater", package: "OrzAppUpdater")
```

## 使用

```swift
import SwiftUI
import OrzAppUpdater

@main
struct OrzApp: App {
    let updaterController = OrzAppUpdaterController()
    var body: some Scene {
        WindowGroup {
        }
        .addCheckUpdatesCommand(updaterController: updaterController)
    }
}
```

## 必选配置

Info.plist 必须包含：

| Key | 说明 | 示例 |
| --- | --- | --- |
| SUFeedURL | appcast.xml 地址 | https://yourcompany.example.com/appcast.xml |
| SUPublicEDKey | Ed25519 公钥 | BASE64_PUBLIC_KEY |
| CFBundleVersion | 构建版本号 | 100 |

```xml
<key>SUFeedURL</key>
<string>https://yourcompany.example.com/appcast.xml</string>
<key>SUPublicEDKey</key>
<string>BASE64_PUBLIC_KEY</string>
```

## appcast 生成

```bash
tar -cJf YourApp.tar.xz /path/to/YourApp.app
./bin/generate_appcast /path/to/updates_folder
```

## 接入自检

```swift
let issues = OrzAppUpdaterDiagnostics.infoPlistIssues()
if !issues.isEmpty {
    print(issues.joined(separator: "\n"))
}
```

## Links

- https://sparkle-project.org/
- https://sparkle-project.org/documentation/
