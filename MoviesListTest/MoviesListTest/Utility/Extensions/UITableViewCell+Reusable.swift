//
//  UITableViewCell+Reusable.swift
//  MoviesListTest
//
//  Created by Sofiia Lushchanets on 24.11.2020.
//

import UIKit

protocol Reusable {}

extension UITableViewCell: Reusable {}

extension Reusable where Self: UITableViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}
