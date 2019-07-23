//
//  ErrorDisplayDelegate.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import UIKit

protocol ErrorDisplayDelegate {
    func show(title: String, message: String)
}

extension UIViewController: ErrorDisplayDelegate {
    func show(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: false)
    }
}
