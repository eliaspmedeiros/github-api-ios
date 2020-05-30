//
//  RepositoryListViewController.swift
//  GitApi
//
//  Created by Elias Medeiros on 29/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {
    var presenter: RepositoryListModuleInterface!

    @IBOutlet weak var label: UILabel!

    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

}

extension RepositoryListViewController: RepositoryListViewInterface {
    func reload(title: String) {
        label.text = title
    }
}
