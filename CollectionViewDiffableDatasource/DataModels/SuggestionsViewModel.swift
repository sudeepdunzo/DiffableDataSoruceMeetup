//
//  SuggestionsViewModel.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 17/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import Foundation
import UIKit

struct Suggestion {
    let name: String
    let identifier = NSUUID()

    init(name: String) {
        self.name = name
    }
}

extension Suggestion: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Suggestion, rhs: Suggestion) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}


extension Suggestion {
    
    func getContinerWidth(forHight hight :CGFloat) -> CGFloat {

        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: hight)
                
                
        let boundingBox = self.name.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)

            return ceil(boundingBox.width)
    
    }
    
}
