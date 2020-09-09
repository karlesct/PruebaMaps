//
//  UIAlertController+Builder.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 08/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

public extension UIAlertController {

    class Builder {

        // MARK: - Properties

        private var preferredStyle: UIAlertController.Style = .alert
        private var title: String?
        private var message: String?
        private var alertActions: [UIAlertAction] = [UIAlertAction]()
        private var sourceView: UIView?
        private var sourceRect: CGRect?

        // MARK: - Init

        init() {

        }

        // MARK: - Methods

        func withPreferredStyle(_ preferredStyle: UIAlertController.Style) -> Builder {

            self.preferredStyle = preferredStyle
            return self
        }

        func withTitle(_ title: String?) -> Builder {

            self.title = title
            return self
        }

        func withMessage(_ message: String?) -> Builder {

            self.message = message
            return self
        }

        func withAlertActions(_ alertActions: [UIAlertAction]) -> Builder {

            self.alertActions = alertActions
            return self
        }

        func withSourceView(_ sourceView: UIView?) -> Builder {

            self.sourceView = sourceView
            return self
        }

        func withSourceRect(_ sourceRect: CGRect?) -> Builder {

            self.sourceRect = sourceRect
            return self
        }

        func addActionWithTitle(_ title: String, alertActionStyle: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) -> Builder {

            let action = UIAlertAction(title: title, style: alertActionStyle, handler: handler)
            self.alertActions.append(action)
            return self
        }

        func showIn(_ viewController: UIViewController, animater: Bool = true, completion: (() -> Void)? = nil) {

            viewController.present(build(), animated: animater, completion: completion)
        }

        func show(animater: Bool = true, completion: (() -> Void)? = nil) {

            guard let viewController = UIViewController().getTopViewController else { return }
            viewController.present(build(), animated: true, completion: nil)
        }

        func build() -> UIAlertController {

            let alertController = UIAlertController(title: self.title,
                                                    message: self.message,
                                                    preferredStyle: self.preferredStyle)

            if let sourceView = self.sourceView {
                alertController.popoverPresentationController?.sourceView = sourceView
            }

            if let sourceRect = self.sourceRect {
                alertController.popoverPresentationController?.sourceRect = sourceRect
            }

            alertActions.forEach { action in
                alertController.addAction(action)
            }

            return alertController

        }

    }

}
