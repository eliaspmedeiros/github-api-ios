//
//  LoadingTableViewCell.swift
//  GitApi
//
//  Created by Elias Medeiros on 31/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit


class LoadingTableViewCell: BaseTableViewCell {
    // MARK: components
    private let activityIndicator: UIActivityIndicatorView = {
        $0.style = .large
        return $0
    }(UIActivityIndicatorView())

    override var customSubviews: [UIView] {
        [activityIndicator]
    }

    override func setupAutoLayout() {
        activityIndicator.constrainInside(parent: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        activityIndicator.startAnimating()
    }
}
