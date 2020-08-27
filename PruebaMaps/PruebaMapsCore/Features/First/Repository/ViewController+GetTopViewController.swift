//
//  ViewController+GetTopViewController.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

extension UIViewController {

    var getTopViewController: UIViewController? {
        let appDelegate = UIApplication.shared.delegate
        if let window = appDelegate?.window {
            return window?.visibleViewController
        }
        return nil
    }

}
