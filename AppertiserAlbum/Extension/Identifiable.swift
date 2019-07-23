//
//  Identifiable.swift
//  AppertiserAlbum
//
//  Created by Ella on 23/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import UIKit

protocol Identifiable {
    static var id: String { get }
}

extension Identifiable {
    static var id: String {
        return String(describing: self)
    }
}

extension UIView: Identifiable {}
