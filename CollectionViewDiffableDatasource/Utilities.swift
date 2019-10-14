//
//  Utilities.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 14/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import Foundation
import UIKit


protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension ReusableCell {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib? {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
}

extension UITableViewCell: ReusableCell {}

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
    
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableCell {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: ReusableCell {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T?
    }
}



extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: ReusableCell {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ReusableCell {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath, retrunType: T.Type) -> T where T: ReusableCell {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func registerReusableSupplementaryView<T: ReusableCell>(elementKind: String, _: T.Type) {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(elementKind: String, indexPath: IndexPath) -> T where T: ReusableCell {
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
