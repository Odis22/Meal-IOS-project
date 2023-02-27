//
//  UIStackViewExtension.swift
//  fetchingdeserts
//
//  Created by Odinaka Amadi on 2/27/23.
//

import Foundation

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: Distribution ) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
}
