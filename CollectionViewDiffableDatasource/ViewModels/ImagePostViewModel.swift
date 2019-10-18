//
//  ImagePostViewModel.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 17/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import Foundation
import UIKit



struct ImagePostViewModel {
    let id:String
    let description:String?
    let url:String
    private let aspectRatio:CGFloat
    init(id:String,url:String,height:Int,width:Int,description:String? = nil) {
    self.id = id
    self.url = url
    self.description = description
    self.aspectRatio = CGFloat(height)/CGFloat(width)
    }
}

extension ImagePostViewModel:Hashable{
    static func == (lhs: ImagePostViewModel, rhs: ImagePostViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ImagePostViewModel {
    func getHeight(forContainerWidth width:CGFloat) -> CGFloat{
        return  self.aspectRatio * width
    }
}





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




extension ImagePost:Hashable {
    static func == (lhs: ImagePost, rhs: ImagePost) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
