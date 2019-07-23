//
//  StringExtension.swift
//  AppertiserAlbum
//
//  Created by Ella on 23/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import Foundation

extension String{
    var localized: String {
        let localized = NSLocalizedString(self, tableName: nil,
                                          bundle: Bundle.main, value: "",
                                          comment: "")
        return localized
    }
}
