//
//  DetailViewController.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var content: Album? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.albumDetails
        configureView()
    }

    private func configureView() {
        guard let detail = content else { return }
        if let trackName = detail.trackName, let label = detailDescriptionLabel {
            label.text = String(describing: trackName)
        }
        if let genre = detail.genre, let label = genreLabel {
            label.text = "\(Constants.genre) \(String(describing: genre))"
        }

        if let label = priceLabel {
            label.text = String(format: "\(Constants.price)", detail.price)
        }

        if let textView = descriptionTextView {
            textView.text = detail.description
        }

        guard let imageLink =  detail.artworkSmall,
            let imageUrl = URL(string: imageLink), let imgView = imageView else { return }
        let options = ImageLoadingOptions(
            placeholder: #imageLiteral(resourceName: "placeholder"),
            failureImage: #imageLiteral(resourceName: "placeholder"),
            contentModes: .init(
                success: .scaleToFill,
                failure: .center,
                placeholder: .center
            )
        )
        Nuke.loadImage(with: imageUrl, options: options, into: imgView)
    }
}

