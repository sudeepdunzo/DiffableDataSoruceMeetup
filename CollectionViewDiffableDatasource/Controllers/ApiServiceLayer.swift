//
//  ApiServiceLayer.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 13/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import Foundation
import Alamofire






struct CollectionPost:Decodable,Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: CollectionPost, rhs: CollectionPost) -> Bool {
        return lhs.id == rhs.id
    }
    
    let description:String?
    let id:String
    let title:String?
    let color:String?
    let cover_photo:ImagePost
    
}



struct ImageSearchResults:Decodable {
    let total:Int
    let total_pages:Int
    let results:[ImagePost]
}


struct CollectionSearchResults:Decodable {
    let total:Int
    let total_pages:Int
    let results:[CollectionPost]
}


/*
 
    {
      "total": 133,
      "total_pages": 7,
      "results": [
        {
          "id": "eOLpJytrbsQ",
          "created_at": "2014-11-18T14:35:36-05:00",
          "width": 4000,
          "height": 3000,
          "color": "#A7A2A1",
          "likes": 286,
          "liked_by_user": false,
          "description": "A man drinking a coffee.",
          "user": {
            "id": "Ul0QVz12Goo",
            "username": "ugmonk",
            "name": "Jeff Sheldon",
            "first_name": "Jeff",
            "last_name": "Sheldon",
            "instagram_username": "instantgrammer",
            "twitter_username": "ugmonk",
            "portfolio_url": "http://ugmonk.com/",
            "profile_image": {
              "small": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=7cfe3b93750cb0c93e2f7caec08b5a41",
              "medium": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=5a9dc749c43ce5bd60870b129a40902f",
              "large": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=32085a077889586df88bfbe406692202"
            },
            "links": {
              "self": "https://api.unsplash.com/users/ugmonk",
              "html": "http://unsplash.com/@ugmonk",
              "photos": "https://api.unsplash.com/users/ugmonk/photos",
              "likes": "https://api.unsplash.com/users/ugmonk/likes"
            }
          },
          "current_user_collections": [],
          "urls": {
            "raw": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f",
            "full": "https://hd.unsplash.com/photo-1416339306562-f3d12fefd36f",
            "regular": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=92f3e02f63678acc8416d044e189f515",
            "small": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=263af33585f9d32af39d165b000845eb",
            "thumb": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=8aae34cf35df31a592f0bef16e6342ef"
          },
          "links": {
            "self": "https://api.unsplash.com/photos/eOLpJytrbsQ",
            "html": "http://unsplash.com/photos/eOLpJytrbsQ",
            "download": "http://unsplash.com/photos/eOLpJytrbsQ/download"
          }
        },
        // more photos ...
      ]
    }
 */





/* collections
 
 {
   "total": 237,
   "total_pages": 12,
   "results": [
     {
       "id": 193913,
       "title": "Office",
       "description": null,
       "published_at": "2016-04-15T21:05:44-04:00",
       "curated": false,
       "featured": true,
       "total_photos": 60,
       "private": false,
       "share_key": "79ec77a237f014935eddc774f6aac1cd",
       "cover_photo": {
         "id": "pb_lF8VWaPU",
         "created_at": "2015-02-12T18:39:43-05:00",
         "width": 5760,
         "height": 3840,
         "color": "#1F1814",
         "likes": 786,
         "liked_by_user": false,
         "description": "A man drinking a coffee.",
         "user": {
           "id": "tkoUSod3di4",
           "username": "gilleslambert",
           "name": "Gilles Lambert",
           "first_name": "Gilles",
           "last_name": "Lambert",
           "instagram_username": "instantgrammer",
           "twitter_username": "gilleslambert",
           "portfolio_url": "http://www.gilleslambert.be/photography",
           "profile_image": {
             "small": "https://images.unsplash.com/profile-1445832407811-c04ed64d238b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=4bb8fad0dcba43c46491c6fd0b92f537",
             "medium": "https://images.unsplash.com/profile-1445832407811-c04ed64d238b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=a6d8602c855914fe13650eedd5996cb5",
             "large": "https://images.unsplash.com/profile-1445832407811-c04ed64d238b?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=26099ca5069692aac6973d08ae02dd71"
           },
           "links": {
             "self": "https://api.unsplash.com/users/gilleslambert",
             "html": "http://unsplash.com/@gilleslambert",
             "photos": "https://api.unsplash.com/users/gilleslambert/photos",
             "likes": "https://api.unsplash.com/users/gilleslambert/likes"
           }
         },
         "urls": {
           "raw": "https://images.unsplash.com/photo-1423784346385-c1d4dac9893a",
           "full": "https://hd.unsplash.com/photo-1423784346385-c1d4dac9893a",
           "regular": "https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=d60d527cb347746ab3abf5fccecf0271",
           "small": "https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=0bf0c97abca8b2741380f38d3debd45f",
           "thumb": "https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=9bc3a6d42a16809b735c22720de3fb13"
         },
         "links": {
           "self": "https://api.unsplash.com/photos/pb_lF8VWaPU",
           "html": "http://unsplash.com/photos/pb_lF8VWaPU",
           "download": "http://unsplash.com/photos/pb_lF8VWaPU/download"
         }
       },
       "user": {
         "id": "k_gSWNtOjS8",
         "username": "cjmconnors",
         "name": "Christine Connors",
         "portfolio_url": null,
         "bio": "",
         "profile_image": {
           "small": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=0ad68f44c4725d5a3fda019bab9d3edc",
           "medium": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=356bd4b76a3d4eb97d63f45b818dd358",
           "large": "https://images.unsplash.com/placeholder-avatars/extra-large.jpg?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=ee8bbf5fb8d6e43aaaa238feae2fe90d"
         },
         "links": {
           "self": "https://api.unsplash.com/users/cjmconnors",
           "html": "http://unsplash.com/@cjmconnors",
           "photos": "https://api.unsplash.com/users/cjmconnors/photos",
           "likes": "https://api.unsplash.com/users/cjmconnors/likes"
         }
       },
       "links": {
         "self": "https://api.unsplash.com/collections/193913",
         "html": "http://unsplash.com/collections/193913/office",
         "photos": "https://api.unsplash.com/collections/193913/photos",
         "related": "https://api.unsplash.com/collections/193913/related"
       }
     },
     // more collections...
   ]
 }
 
 */


protocol SearchAPIProtocol {
    
    var onPhotosFetch:((_ results:[ImagePost]?,_ canLoadMore:Bool,_ success:Bool)->())? { get set }
    var onCategoryFetch:((_ results:[CollectionPost]?,_ canLoadMore:Bool,_ success:Bool)->())? { get set }
    
    mutating func getPhotos(for searchTerm:String,fetchCollections:Bool)
    
    mutating func loadMore()

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


class UnSplashServiceController:SearchAPIProtocol {

    

    
    private let baseUrl = "https://api.unsplash.com/"
    private lazy var headers:HTTPHeaders = [
        "Authorization": "Client-ID ac98be4d7c7768b1a7c16ad2c8242ee2a3ec70afa4ff675ed9b7f14e6a3e7e26",
        "Accept-Version": "v1"
    ]
    
    lazy var workQueue:DispatchQueue = DispatchQueue(label: "API Worker Queue")
    
    
    
    private var searchTerm:String? = nil
    private var currentPhotosPageNumber:Int = 0
    private var photoLimitReached:Bool = false
    private var currentCollectionsPageNumber:Int = 0
    private var collectionLimitReached:Bool = false
    
    private var fetchCollections = false
    
    
    private var isMakingApiCall = false
    
    var onCategoryFetch: (([CollectionPost]?, Bool, Bool) -> ())?
    var onPhotosFetch: (([ImagePost]?, Bool, Bool) -> ())?
    
    
    
    func getPhotos(for searchTerm: String, fetchCollections: Bool) {
        self.searchTerm = searchTerm
        self.currentPhotosPageNumber = 1
        self.photoLimitReached = false
        self.currentCollectionsPageNumber = 1
        self.collectionLimitReached = false
        self.fetchCollections = fetchCollections
        self.makeApiCall(with: searchTerm, page: self.currentPhotosPageNumber)
        if self.fetchCollections == true {
            self.makeApiCallCollections(with: searchTerm, page:self.currentCollectionsPageNumber)
        }
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
                                   self.onPhotosFetch?(imageReponse.results,imageReponse.results.count > 0,true)
                                    self.photoLimitReached = !(imageReponse.results.count > 0)
                               }else{
                                   self.onPhotosFetch?(nil,true,false)
                               }
                               
                           }
            }
        }
    }
    
    
    private func makeApiCallCollections(with searchTerm:String, page:Int) {
         
         let params:[String:Any] = ["query":searchTerm,"page":page,"per_page":10]
         
         workQueue.async {
             
             AF.request(self.baseUrl+"/search/Collections", method: .get, parameters:params ,encoding:URLEncoding(destination: .queryString), headers: self.headers).responseDecodable(of: CollectionSearchResults.self, queue: self.workQueue) { (response) in
                 
                 if let imageReponse = response.value {
                     self.currentPhotosPageNumber = page
                    self.onCategoryFetch?(imageReponse.results,imageReponse.results.count > 0,true)
                    self.collectionLimitReached = !(imageReponse.results.count > 0)
                 }else{
                     self.onCategoryFetch?(nil,true,false)
                 }
                 
             }
         
         }
     }
    
    
    func loadMore() {
         
        if let search = self.searchTerm {
            self.makeApiCall(with: search, page: self.currentPhotosPageNumber+1)
            if self.fetchCollections {
                self.makeApiCallCollections(with:search , page: self.currentCollectionsPageNumber)
            }
            
        }
        
    }
}





