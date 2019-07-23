//
//  AlbumList.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AlbumList: Codable {
    var albums: [Album]?

    init?(json: JSON) {
        guard let jsonDictionary = json.dictionary, let jsonArray = jsonDictionary["results"]?.array else { return nil }
        var albums = [Album]()
        jsonArray.forEach { data in
            if let album = Album(json: data) {
                albums.append(album)
            }
        }
        self.albums = albums
    }
}
