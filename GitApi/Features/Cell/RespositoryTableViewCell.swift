//
//  RespositoryTableViewCell.swift
//  GitApi
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

class RespositoryTableViewCell: UITableViewCell {
    // MARK: components
    private let nameLabel: UILabel = {
        return $0
    }(UILabel())

    private let starCountLabel: UILabel = {
        return $0
    }(UILabel())

    private let ownerPictureImageView: UIImageView = {
        return $0
    }(UIImageView())

    private let ownerNameLabel: UILabel = {
        return $0
    }(UILabel())

    var customSubviews: [UIView] {
        [nameLabel, starCountLabel, ownerPictureImageView, ownerNameLabel]
    }

    // MARK: life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        customSubviews.forEach(self.addSubview)

        let defaultSideMargin: CGFloat = 14
        nameLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: defaultSideMargin, paddingLeft: defaultSideMargin)
        starCountLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, paddingTop: 10, paddingLeft: 0)
        ownerPictureImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingRight: defaultSideMargin, width: 60, height: 60)
        ownerNameLabel.anchor(top: ownerPictureImageView.bottomAnchor, right: ownerPictureImageView.rightAnchor, paddingTop: 10, paddingRight: 0)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        nameLabel.text = nil
        starCountLabel.text = nil
        ownerPictureImageView.image = nil
        ownerNameLabel.text = nil
    }

    // MARK: internal methods
    func config(with model: RepositoryModel) {
        nameLabel.text = model.name
        starCountLabel.text = "\(model.starCount) ⭐️"
        ownerPictureImageView.load(fromUrl: model.owner.picture, placeholder: .defaultPlaceholder)
        ownerNameLabel.text = model.owner.name
    }

    // MARK: private methods


}

extension RespositoryTableViewCell {

    // MARK: constants
    static let cellIdentifier = "repo-cell"
}
