// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Sparkle
import Foundation

public typealias OrzAppUpdaterController = SPUStandardUpdaterController
extension OrzAppUpdaterController {
    public convenience init(startingUpdater: Bool = true) {
        self.init(startingUpdater: startingUpdater, updaterDelegate: nil, userDriverDelegate: nil)
    }
}

extension Scene {
    public func addCheckUpdatesCommand(
        updaterController: OrzAppUpdaterController,
        title: String = "Check for Updates..."
    ) -> some Scene {
        self.commands {
            CommandGroup(after: .appInfo) {
                CheckForUpdatesView(updater: updaterController.updater, title: title)
            }
        }
    }
}

public struct OrzAppUpdaterDiagnostics {
    public static func infoPlistIssues(bundle: Bundle = .main) -> [String] {
        let info = bundle.infoDictionary ?? [:]
        var issues: [String] = []
        let feedURLString = (info["SUFeedURL"] as? String) ?? ""
        let publicKey = (info["SUPublicEDKey"] as? String) ?? ""
        let bundleVersion = (info["CFBundleVersion"] as? String) ?? ""
        if feedURLString.isEmpty {
            issues.append("Missing SUFeedURL")
        } else if URL(string: feedURLString) == nil {
            issues.append("Invalid SUFeedURL")
        }
        if publicKey.isEmpty {
            issues.append("Missing SUPublicEDKey")
        }
        if bundleVersion.isEmpty {
            issues.append("Missing CFBundleVersion")
        }
        return issues
    }
}

final class CheckForUpdatesViewModel: ObservableObject {
    @Published var canCheckForUpdates = false
    init(updater: SPUUpdater) {
        updater
            .publisher(for: \.canCheckForUpdates)
            .assign(to: &$canCheckForUpdates)
    }
}

struct CheckForUpdatesView: View {
    @ObservedObject private var checkForUpdatesViewModel: CheckForUpdatesViewModel
    private let updater: SPUUpdater
    private let title: String
    
    init(updater: SPUUpdater, title: String) {
        self.updater = updater
        self.title = title
        // Create our view model for our CheckForUpdatesView
        self.checkForUpdatesViewModel = CheckForUpdatesViewModel(updater: updater)
    }
    var body: some View {
        Button(title, action: updater.checkForUpdates)
            .disabled(!checkForUpdatesViewModel.canCheckForUpdates)
            .keyboardShortcut(.init("u"), modifiers: /*@START_MENU_TOKEN@*/.command/*@END_MENU_TOKEN@*/)
    }
}
