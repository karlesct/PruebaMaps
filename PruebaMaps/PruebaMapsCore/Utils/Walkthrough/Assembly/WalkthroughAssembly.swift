//
//  WalkthroughAssembly.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 14/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

public final class WalkthroughAssembly {

    // MARK: - Properties

    // MARK: - Init

    public init() {

    }

    // MARK: - Public Methods

    public func viewController() -> UIViewController {

        return buildViewController()
        //return UIViewController()

    }

    // MARK: - Internal Methods

    private func buildViewController() -> UIViewController {

        let viewControllers: [UIViewController] = buildWalkthroughElements().map { element in
            let page = WalkthroughPageViewController(element: element)
            return page
        }

        return WalkthroughViewController(viewControllers: viewControllers)
    }

    private func buildWalkthroughElements() -> [WalkthroughElement] {

        let elements = [
            WalkthroughElement(title: "Quick Overview",
                               subtitle: "Quickly visualize important business metrics. The overview in the home tab shows the most important metrics to monitor how your business is doing.",
                               image: "analytics-icon"),
            WalkthroughElement(title: "Analytics",
                               subtitle: "Dive deep into charts to extract valuable insights and come up with data driven product initiatives, to boost the success of your business.",
                               image: "bars-icon"),
            WalkthroughElement(title: "Dashboard Feeds",
                               subtitle: "View your sales feed, orders, customers, products and employees.",
                               image: "activity-feed-icon"),
            WalkthroughElement(title: "Get Notified",
                               subtitle: "Receive notifications when critical situations occur to stay on top of everything important.",
                               image: "bell-icon")

        ]

        return elements

    }

}
