//
//  PermissionsScreen.swift
//
//  Created by James Sedlacek on 12/17/25.
//

import SwiftUI

/// Defines available permission priming screens.
@MainActor
public enum PermissionsScreen {
    case notifications(NotificationsPriming.Configuration)
}

public extension PermissionsScreen {
    static func notifications(
        accentColor: Color = .blue,
        title: LocalizedStringKey = .notificationsTitleDefault,
        subtitle: LocalizedStringKey,
        appIcon: Image? = nil,
        allowAction: @escaping () -> Void = {},
        skipAction: (() -> Void)? = nil,
        bundle: Bundle? = nil
    ) -> Self {
        .notifications(
            .init(
                accentColor: accentColor,
                title: title,
                subtitle: subtitle,
                appIcon: appIcon,
                allowAction: allowAction,
                skipAction: skipAction,
                bundle: bundle
            )
        )
    }

    func with(
        allowAction: @escaping () -> Void,
        skipAction: (() -> Void)? = nil
    ) -> Self {
        switch self {
        case let .notifications(configuration):
            return .notifications(
                configuration.with(
                    allowAction: allowAction,
                    skipAction: skipAction
                )
            )
        }
    }
}

@MainActor
public extension PermissionsScreen {
    static let mock: Self = .notifications(.mock)
}

@MainActor
extension PermissionsScreen: View {
    public var body: some View {
        switch self {
        case let .notifications(configuration):
            NotificationsPriming(config: configuration)
        }
    }
}

#Preview {
    PermissionsScreen.mock
}
