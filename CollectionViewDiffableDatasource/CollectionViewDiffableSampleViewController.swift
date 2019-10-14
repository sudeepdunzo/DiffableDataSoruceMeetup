//
//  ViewController.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 07/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import UIKit


struct SectionsData:Hashable {
    let sectionID:Int
}

struct ItemsViewModel: Hashable{
    var itemID:Int
}





class CollectionViewDiffableSampleViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<SectionsData, ItemsViewModel>! = nil
    var apiContoller: UnSplashServiceController! {
        didSet {
            apiContoller.onPhotosFetch = { (result,canLoadMore,success) in
                print("result:\(String(describing: result)) can load more : \(canLoadMore), success \(success)")
            }
        }
        
    }
    
    
    
    
    @IBOutlet var searchView: UISearchBar!
    
    @IBOutlet var colltionView: UICollectionView! {
        didSet{
            if let collectionView = colltionView {
                registerCellsTo(CollectionView: collectionView)
                self.dataSource = UICollectionViewDiffableDataSource<SectionsData, ItemsViewModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemData:ItemsViewModel) -> UICollectionViewCell? in
                    
                    let cell = collectionView.dequeueReusableCell(indexPath: indexPath, retrunType:ImageCollectionViewCell.self)
                        
                        
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

