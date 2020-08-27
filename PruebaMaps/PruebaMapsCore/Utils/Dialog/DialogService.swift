//
//  DialogService.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

public protocol DialogServiceProtocol {

    func showAlert(title: String?, message: String?, btAcceptText: String?)
    func showAlert(title: String?, message: String?, btAcceptText: String?, btAcceptCompletion: @escaping () -> Void)
    func showAlert(title: String?, message: String?, btAcceptText: String?, btCancelText: String?, btAcceptCompletion: @escaping () -> Void)
    func showAlert(title: String?, message: String?, btAcceptText: String?, btAcceptCompletion: @escaping () -> Void, btCancelCompletion: @escaping () -> Void)
}

public class DialogService: NSObject, DialogServiceProtocol {

    // MARK: - Fields

    // MARK: - Init

    public override init() {
        super.init()
    }

    // MARK: - Accessible Methods

    public func showAlert(title: String?,
                          message: String?,
                          btAcceptText: String?) {

        DispatchQueue.main.async {

            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: btAcceptText,
                                                    style: .default))

            alertController.show()
        }
    }

    public func showAlert(title: String?,
                          message: String?,
                          btAcceptText: String?,
                          btAcceptCompletion: @escaping () -> Void) {

        DispatchQueue.main.async {

            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)

            let action = UIAlertAction(title: btAcceptText,
                                       style: .default) { _ in
                                        btAcceptCompletion()
            }

            alertController.addAction(action)

            alertController.show()

        }
    }

    public func showAlert(title: String?,
                          message: String?,
                          btAcceptText: String?,
                          btCancelText: String?,
                          btAcceptCompletion: @escaping () -> Void) {

        DispatchQueue.main.async {

            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: btCancelText,
                                             style: .cancel,
                                             handler: nil)

            alertController.addAction(cancelAction)

            let action = UIAlertAction(title: btAcceptText,
                                       style: .default) { _ in
                                        btAcceptCompletion()
            }

            alertController.addAction(action)

            alertController.show()

        }
    }

    public func showAlert(title: String?,
                          message: String?,
                          btAcceptText: String?,
                          btAcceptCompletion: @escaping () -> Void,
                          btCancelCompletion: @escaping () -> Void) {

        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "cancel",
                                             style: .cancel) { _ in
                                                btCancelCompletion()
            }
            alertController.addAction(cancelAction)

            let action = UIAlertAction(title: btAcceptText,
                                       style: .default) { _ in
                                        btAcceptCompletion()
            }
            alertController.addAction(action)

            alertController.show()
        }
    }
}

public extension UIAlertController {

    func show() {

        guard let viewController = UIViewController().getTopViewController else { return }

        viewController.present(self, animated: true, completion: nil)
    }
}
