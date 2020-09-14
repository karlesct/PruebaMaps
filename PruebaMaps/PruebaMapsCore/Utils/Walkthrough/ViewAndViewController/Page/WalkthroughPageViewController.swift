//
//  WalkthroughPageViewController.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 14/09/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

public final class WalkthroughPageViewController: UIViewController {

    // MARK: - IBoutlets

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!

    // MARK: - Fields

    let element: WalkthroughElement

    // MARK: - Init

    init(element: WalkthroughElement) {
        self.element = element
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.bind(with: self.element)
        vwContainer.backgroundColor = .red
    }

    private func bind(with element: WalkthroughElement) {

        ivImage.image = UIImage.init(named: element.image)?.withRenderingMode(.alwaysTemplate)
        lblTitle.text = element.title
        lblSubtitle.text = element.subtitle

    }
}
