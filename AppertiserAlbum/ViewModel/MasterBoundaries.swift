//
//  MasterBoundaries.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

protocol MasterInput {
    func fetchData()
}

protocol MasterOutput: class, Loadable, ErrorDisplayDelegate {
    func displayData()
}
