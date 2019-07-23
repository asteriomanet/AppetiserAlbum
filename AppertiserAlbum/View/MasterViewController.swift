//
//  MasterViewController.swift
//  AppertiserAlbum
//
//  Created by Ella on 20/07/2019.
//  Copyright © 2019 Ella. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var viewModel: MasterViewModel?

    override func loadView() {
        super.loadView()
        initializeViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchData()
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        title = Constants.albumTitle
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = viewModel?.contentAt(indexPath: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.content = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    private func initializeViewModel() {
        viewModel = MasterViewModel()
        viewModel?.view = self
    }
}

extension MasterViewController: MasterOutput {
    func displayData() {
        tableView.reloadData()
        if let latestVisit = Date().currentDate.data(using: .utf8) {
            CacheCoordinator.persist(data: latestVisit, for: CacheKey.currentDate.rawValue)
        }

    }
}

// MARK: - Table View
extension MasterViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let masterCell = tableView.dequeueReusableCell(withIdentifier: MasterCell.id, for: indexPath)
        guard let cell = masterCell as? MasterCell else { return masterCell }
        let object = viewModel?.contentAt(indexPath: indexPath)
        cell.content = object
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var lastVisitedDate: String
        if let lastVisitedData = CacheCoordinator.retrieveData(for: CacheKey.currentDate.rawValue) {
            let lastVisit =  String(decoding: lastVisitedData, as: UTF8.self)
            lastVisitedDate = lastVisit
        } else {
            lastVisitedDate = Date().currentDate
        }
        return "\(Constants.lastVisit) \(lastVisitedDate)"
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
}

