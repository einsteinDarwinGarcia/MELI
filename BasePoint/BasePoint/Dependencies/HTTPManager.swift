//
//  HTTPManager.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 11/05/21.
//

import Foundation

protocol HTTPManagerProtocol {
    func get(url: String, completionBlock: @escaping (Result<String, Error>) -> Void)
}

class HTTPManager: HTTPManagerProtocol {
    public func get(url: String, completionBlock: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let data = (url == "001") ? "Einstein": "No Authorized"
            completionBlock(.success(data))
        }
    }
}
