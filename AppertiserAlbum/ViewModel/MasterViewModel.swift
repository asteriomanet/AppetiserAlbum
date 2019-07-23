//
//  MasterViewModel.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ListRequest {
    var country: String
    var term: String
    var media: String
}

final class MasterViewModel {
    weak var view: MasterOutput?
    var data: AlbumList?

    func numberOfRows() -> Int {
        return data?.albums?.count ?? 0
    }

    func contentAt(indexPath: IndexPath) -> Album? {
        return data?.albums?[indexPath.row]
    }
}

extension MasterViewModel: MasterInput {
    func fetchData() {
        // Check if data were already persisted, if so load the persisted data
        if let cacheList = CacheCoordinator.retrieveData(for: CacheKey.albumList.rawValue),
            let list = try? JSONDecoder().decode(AlbumList.self, from: cacheList) {
            data = list
            view?.displayData()
            return
        }

        let request = ListRequest(country: "au", term: "star", media: "movie")
        view?.startLoading()
        APIProvider.request(.list(request)) {[unowned self] result in
            self.view?.stopLoading()
            switch result {
            case .success(let response):
                let json = JSON(response.data)
                self.data = AlbumList(json: json)
                if let data = try? JSONEncoder().encode(self.data) {
                    CacheCoordinator.persist(data: data, for: CacheKey.albumList.rawValue)
                }
                self.view?.displayData()
            case .failure(let error):
                self.view?.show(title: "Error", message: error.localizedDescription)
            }
        }
    }
}


