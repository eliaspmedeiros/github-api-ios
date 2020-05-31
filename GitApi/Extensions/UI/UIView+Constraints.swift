//
//  UIView+Constraints.swift
//  GitApi
//
//  Created by Elias Medeiros on 30/05/20.
//  Copyright © 2020 Corp. All rights reserved.
//

import UIKit

//public extension UIView {
//    func constrainInside(parent parentView: UIView, withPadding padding: CGFloat = 0) {
//        self.constrainInside(parent: parentView, withPadding: (padding, padding))
//    }
//
//    func constrainInside(parent parentView: UIView, withPadding padding: (vertical: CGFloat, horizontal: CGFloat)) {
//        constrainInside(parent: parentView, withPadding: (padding.horizontal, padding.vertical, padding.horizontal, padding.vertical))
//    }
//
//    func constrainInside(parent parentView: UIView, withPadding padding: (left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat)) {
//        let left = leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: padding.left)
//        let top = topAnchor.constraint(equalTo: parentView.topAnchor, constant: padding.top)
//        let right = trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -padding.right)
//        let bottom = bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -padding.bottom)
//
//        translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([ left, top, right, bottom ])
//    }
//}

extension UIView {
    /// A shortcut to just anchor to top left
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0) {

        anchor(top: top, left: left, bottom: nil, right: nil, paddingTop: paddingTop, paddingLeft: paddingLeft)
    }

    /// A shortcut to just anchor to top right
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingRight: CGFloat = 0) {

        anchor(top: top, left: nil, bottom: nil, right: right, paddingTop: paddingTop, paddingRight: paddingRight)
    }

    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }

    
}
