//
//  MasterCell.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import UIKit
import Nuke

class MasterCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!

    var content: Album? {
        didSet {
            guard let content = content else { return }
            if let trackName = content.trackName {
                titleLabel.text = "\(Constants.trackName) \(String(describing: trackName))"
            }
            if let genre = content.genre {
                genreLabel.text = "\(Constants.genre) \(String(describing: genre))"
            }
            priceLabel.text = String(format: "\(Constants.price)", content.price)
            guard let imageLink =  content.artworkSmall,
                let imageUrl = URL(string: imageLink) else { return }
            let options = ImageLoadingOptions(
                placeholder: #imageLiteral(resourceName: "placeholder"),
                failureImage: #imageLiteral(resourceName: "placeholder"),
                contentModes: .init(
                    success: .scaleAspectFit,
                    failure: .center,
                    placeholder: .center
                )
            )

            Nuke.loadImage(with: imageUrl, options: options, into: artworkImageView)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        genreLabel.text = nil
        priceLabel.text = nil
        artworkImageView.image = #imageLiteral(resourceName: "placeholder")
    }
}
