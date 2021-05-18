//
//  Authorized.swift
//  BasePoint
//
//  Created by Einstein Darwin Garcia Mendez on 14/05/21.
//

import Foundation

enum authorizedCases {
    case authorized
    case unAuthorized
}

struct Authorized {
    let state: authorizedCases
}
