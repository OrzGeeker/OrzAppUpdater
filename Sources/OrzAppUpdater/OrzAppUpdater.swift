// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Sparkle

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
