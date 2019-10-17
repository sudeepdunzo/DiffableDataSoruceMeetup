//
//  ImageCollectionViewCell.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 14/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell,ReusableCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    self.contentView.setContentCompressionResistancePriority(.required, for: .vertical)
        
        //contentCompressionResistancePriority(for: .vertical)
        // Initialization code
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        var size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var newFrame = layoutAttributes.frame
//       
//        // Make any additional adjustments to the cell's frame
//        size.width = self.frame.width
//        newFrame.size = size
//        layoutAttributes.frame = newFrame
//        return layoutAttributes
//    }

}
