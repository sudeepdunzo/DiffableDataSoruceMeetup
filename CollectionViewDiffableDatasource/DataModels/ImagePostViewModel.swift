//
//  ImagePostViewModel.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 17/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import Foundation
import UIKit


struct ImageUrls:Decodable {
    let raw:String?
    let full:String?
    let regular:String?
    let small:String?
    let thumb:String?
}

struct ImagePost:Decodable {
    let description:String?
    let color:String?
    let id:String
    let height:Int
    let width:Int
    let urls:ImageUrls
}


extension ImagePost {
    func getHeight(forContainerWidth width:CGFloat) -> CGFloat{
        return  CGFloat(CGFloat(self.height)/CGFloat(self.width) * width)
    }
}

extension ImagePost:Hashable {
    static func == (lhs: ImagePost, rhs: ImagePost) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
