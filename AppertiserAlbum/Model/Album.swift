//
//  Album.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Album: Codable {

    var trackName: String?
    var artworkLarge: String?
    var artworkSmall: String?
    var price: Double
    var genre: String?
    var description: String?

    init?(json: JSON) {
        guard let data = json.dictionary else { return nil }
        trackName = data["trackName"]?.string
        artworkLarge = data["artworkUrl100"]?.string
        artworkSmall = data["artworkUrl30"]?.string
        price = data["collectionPrice"]?.doubleValue ?? 0.0
        genre = data["primaryGenreName"]?.string
        description = data["longDescription"]?.string
    }
}
