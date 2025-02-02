//
//  ResponseType.swift
//  Networking
//
//  Created by Geon Woo lee on 2/3/25.
//

import Foundation

public protocol Respondable: Decodable {
    var status: String { get set }
    var message: String { get set }
}
