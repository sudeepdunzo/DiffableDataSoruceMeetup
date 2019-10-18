//
//  ApiServiceLayer.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 13/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import Foundation
import Alamofire



fileprivate struct ImageSearchResults:Decodable {
    let total:Int
    let total_pages:Int
    let results:[ImagePost]
}







struct SearchQueryObject:Encodable {
    var query:String
    var page:Int
    var per_page:Int
    var orientation:String
    
    init(query:String,page:Int) {
        self.query = query
        self.page = page
        self.per_page = 20
        self.orientation = "squarish"
        
    }
    
}


class UnSplashServiceController {
 


    var onPhotosFetch: (([ImagePostViewModel]?, Bool, Bool) -> ())?

    
    private let baseUrl = "https://api.unsplash.com/"
    private lazy var headers:HTTPHeaders = [
        "Authorization": "Client-ID ac98be4d7c7768b1a7c16ad2c8242ee2a3ec70afa4ff675ed9b7f14e6a3e7e26",
        "Accept-Version": "v1"
    ]
    
    private lazy var workQueue:DispatchQueue = DispatchQueue(label: "API Worker Queue")
    
    private var searchTerm:String? = nil
    private var currentPhotosPageNumber:Int = 0
    private var photoLimitReached:Bool = false
    private var isMakingApiCall = false
    

    func getPhotos(for searchTerm: String) {
        self.searchTerm = searchTerm
        self.currentPhotosPageNumber = 1
        self.photoLimitReached = false
        self.makeApiCall(with: searchTerm, page: self.currentPhotosPageNumber)
    }
    
    
    
    private func makeApiCall(with searchTerm:String, page:Int) {
        
        let params:[String:Any] = ["query":searchTerm,"page":page,"per_page":10,"orientation":"squarish"]
        
        workQueue.async {
            if self.isMakingApiCall == false {
                self.isMakingApiCall = true
                    AF.request(self.baseUrl+"/search/photos", method: .get, parameters:params ,encoding:URLEncoding(destination: .queryString), headers: self.headers).responseDecodable(of: ImageSearchResults.self, queue: self.workQueue) { (response) in
                            self.isMakingApiCall = false
                               if let imageReponse = response.value {
                                   self.currentPhotosPageNumber = page
                                  
                                let imagePosts =  imageReponse.results.map { (post) -> ImagePostViewModel in
                                    return ImagePostViewModel(id: post.id, url: post.urls.small!, height: post.height, width: post.width, description: post.description)
                                }
                                
                                self.onPhotosFetch?(imagePosts,imageReponse.results.count > 0,true)
                                    self.photoLimitReached = !(imageReponse.results.count > 0)
                               }else{
                                   self.onPhotosFetch?(nil,true,false)
                               }
                               
                           }
            }
        }
    }
    
    

    
    
    func loadMore() {
         
        if let search = self.searchTerm {
            self.makeApiCall(with: search, page: self.currentPhotosPageNumber+1)
        }
        
    }
}





