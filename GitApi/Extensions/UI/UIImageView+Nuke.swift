//
//  UIImageView+Nuke.swift
//  GitApi
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func load(fromUrl urlString: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlString) else {
            return
        }

        guard let placeholder = placeholder else {
            Nuke.loadImage(with: url, into: self)

            return
        }

        let options = ImageLoadingOptions(placeholder: placeholder, transition: .fadeIn(duration: 0.3))
        Nuke.loadImage(with: url, options: options, into: self)
    }
}
