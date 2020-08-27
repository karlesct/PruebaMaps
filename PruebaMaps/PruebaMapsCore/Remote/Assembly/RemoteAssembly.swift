//
//  RemoteAssembly.swift
//  PruebaMapsCore
//
//  Created by Carles Cañadas Torrents on 27/08/2020.
//  Copyright © 2020 carlescanadastorrents. All rights reserved.
//

import Foundation

public final class RemoteAssembly {

    // MARK: - Properties
    private(set) lazy var remoteHandler = RemoteHandler(session: URLSession(configuration: .default))

    // MARK: - Init

    public init() {

    }

}
