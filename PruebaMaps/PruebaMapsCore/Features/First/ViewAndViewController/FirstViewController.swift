//
//  FirstViewController.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import UIKit

internal final class FirstViewController: UIViewController {

    // MARK: - IBoutlets

    // MARK: - Properties

    private let presenter: FirstPresenterProtocol


    // MARK: - Init

    init(presenter: FirstPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        presenter.view = self

        presenter.loadView()
    }

    // MARK: - Private methods

    private func setupUI() {


    }

    // MARK: - Actions


}

extension FirstViewController: FirstViewProtocol {

    func setLoading(_ loading: Bool) {

    }

}
