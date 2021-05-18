//
//  ValidateAuthorizationUsesCase.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 14/05/21.
//

import Foundation

protocol ValidateAuthorizationUsesCase {
    func execute(requestValue:ValidateAuthorizationUsesCaseRequestValue,
                 completion: @escaping (Result<Authorized, Error>) -> Void)
}

struct ValidateAuthorizationUsesCaseRequestValue {
    let query: String
    let page: Int
}

final class ImplementeValidateAuthorizationUsesCase: ValidateAuthorizationUsesCase {
    
    var networkingLayer: HTTPManagerProtocol
    
    init(networkingLayer: HTTPManagerProtocol) {
        self.networkingLayer = networkingLayer
    }
    
    func execute(requestValue: ValidateAuthorizationUsesCaseRequestValue, completion: @escaping (Result<Authorized, Error>) -> Void) {
        networkingLayer.get(url: requestValue.query) { (result) in
            switch result {
            case .success(let value):
                if value == "Einstein" {
                    completion(.success(Authorized(state: .authorized)))
                } else {
                    completion(.success(Authorized(state: .unAuthorized)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
