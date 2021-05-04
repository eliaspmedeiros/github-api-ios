//
//  RepositoryTableViewCell.swift
//  GitApi
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: BaseTableViewCell {
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

    override var customSubviews: [UIView] {
        [nameLabel, starCountLabel, ownerPictureImageView, ownerNameLabel]
    }

    // MARK: internal methods
    func config(with model: RepositoryModel?) {
        guard let model = model else {
            clear()
            return
        }

        accessibilityIdentifier = "repository cell"

        nameLabel.text = model.name
        starCountLabel.text = "\(model.starCount) ⭐️"
        ownerPictureImageView.load(fromUrl: model.owner.picture, placeholder: .defaultPlaceholder)
        ownerNameLabel.text = model.owner.name

        nameLabel.accessibilityLabel = "Repositório \(model.name)"
        starCountLabel.accessibilityLabel = "Possui \(model.starCount) estrelas"
        ownerNameLabel.accessibilityLabel = "Proprietário chama-se \(model.owner.name)"
    }

    override func setupAutoLayout() {
        let defaultSideMargin: CGFloat = 14
        nameLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: defaultSideMargin, paddingLeft: defaultSideMargin)
        starCountLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, paddingTop: 10, paddingLeft: 0)
        ownerPictureImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 8, paddingRight: defaultSideMargin, width: 60, height: 60)
        ownerNameLabel.anchor(top: ownerPictureImageView.bottomAnchor, right: ownerPictureImageView.rightAnchor, paddingTop: 10, paddingRight: 0)
    }

    override func clear() {
        nameLabel.text = nil
        starCountLabel.text = nil
        ownerPictureImageView.image = nil
        ownerNameLabel.text = nil
    }
}

