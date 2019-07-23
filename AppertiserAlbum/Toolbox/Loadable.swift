//
//  Loadable.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import UIKit

protocol Loadable {
    func startLoading()
    func stopLoading()
}

extension UIViewController: Loadable {
    func stopLoading() {
        view.subviews.forEach { view in
            if let indicator = view as? UIActivityIndicatorView, indicator.tag ==  1 {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
        UIApplication.shared.endIgnoringInteractionEvents()
    }

    func startLoading() {
        guard !view.subviews.contains(where: { view in
            return view is UIActivityIndicatorView && view.tag == 1
        }) else {
            return
        }
        UIApplication.shared.beginIgnoringInteractionEvents()

        var indicator = UIActivityIndicatorView()
        indicator = UIActivityIndicatorView(frame: view.frame)
        indicator.center = CGPoint(x: view.bounds.origin.x + view.bounds.width /  2,
                                   y: view.bounds.origin.y + view.bounds.height /  2)
        indicator.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        indicator.hidesWhenStopped = true
        indicator.tag = 1
        indicator.stopAnimating()
        view.addSubview(indicator)
    }
}

