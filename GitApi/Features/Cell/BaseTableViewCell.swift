//
//  BaseTableViewCell.swift
//  GitApi
//
//  Created by Elias Medeiros on 31/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    // MARK: constants
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    var customSubviews: [UIView] { [] }

    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        customSubviews.forEach(self.addSubview)
        setupAutoLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        clear()
    }

    // MARK: internal methods
    func setupAutoLayout() { }
    func clear() {}
}

