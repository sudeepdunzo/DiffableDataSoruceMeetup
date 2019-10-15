//
//  ViewController.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 07/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import UIKit
import Kingfisher



enum SectionsData {
    case photos
    case suggestions
    case collections
}






class CollectionViewDiffableSampleViewController: UIViewController {
    
    var imagePosts = [ImagePost]()
    var dataSource: UICollectionViewDiffableDataSource<SectionsData, AnyHashable>! = nil
    var apiContoller: UnSplashServiceController! {
        didSet {
            apiContoller.onPhotosFetch = { (result,canLoadMore,success) in
                print("result:\(String(describing: result)) can load more : \(canLoadMore), success \(success)")
                if let results = result {
                    self.imagePosts.append(contentsOf:results)
                    var snapshot = NSDiffableDataSourceSnapshot<SectionsData, AnyHashable>()
                    let boxedItems = self.imagePosts.map { (imagePost) -> AnyHashable in
                        return AnyHashable(imagePost)
                    }
                    snapshot.appendSections([.photos])
                    snapshot.appendItems(boxedItems, toSection: .photos)
                    self.dataSource.apply(snapshot)
                                    
                }
            }
        }
        
    }
    
    
    
    
    @IBOutlet var searchView: UISearchBar!
    
    @IBOutlet var colltionView: UICollectionView! {
        didSet{
            if let collectionView = colltionView {
                registerCellsTo(CollectionView: collectionView)
                self.dataSource = UICollectionViewDiffableDataSource<SectionsData, AnyHashable>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemData:AnyHashable) -> UICollectionViewCell? in
                    var cell:UICollectionViewCell!
                    if let imageitemData = itemData.base as? ImagePost {
                       let imageCell = collectionView.dequeueReusableCell(indexPath: indexPath, retrunType:ImageCollectionViewCell.self)
                        if let urlString = imageitemData.urls.small, let url = URL(string: urlString) {
                            imageCell.imageView.kf.setImage(with:url)
                            }
                        cell = imageCell
                    }
                    return cell
                })
            }
        }
    }
    
    
    func registerCellsTo(CollectionView collectionView:UICollectionView){
        collectionView.registerReusableCell(ImageCollectionViewCell.self)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiContoller = UnSplashServiceController()
        self.apiContoller.getPhotos(for: "forest", fetchCollections: false)
        
    }


}

