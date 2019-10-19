//
//  ViewController.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 07/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import UIKit
import Kingfisher





class Sample2ViewController: UIViewController {
    
    
    // Controllers
    
    private var suggestions = SuggestionsController()
 
    private var apiContoller: UnSplashServiceController! {
           didSet {
               apiContoller.onPhotosFetch = { (result,canLoadMore,success) in
                   
                   if let results = result {
                    self.dataSourceQueue.async {
                    
                    
                        
                    
                           var snapshot = self.dataSource.snapshot()
                            let boxedItems = results.map { (ImagePostViewModel) -> AnyHashable in
                                return AnyHashable(ImagePostViewModel)
                            }
                            if !snapshot.sectionIdentifiers.contains(.photos) {
                                 snapshot.appendSections([.photos])
                            }
                       
                            snapshot.appendItems(boxedItems, toSection: .photos)
                            self.dataSource.apply(snapshot)
                    }
                       
                   }
               }
           }
       }
    
    
    var dataSource: UICollectionViewDiffableDataSource<SectionViewModels, AnyHashable>! = nil

    
    private var dataSourceQueue =  DispatchQueue(label: "data source queueu")
    
    
 
   
    
    


    
    
    

    private var colletionViewDataMapper:(UICollectionView, IndexPath, AnyHashable) -> UICollectionViewCell? = { (collectionView, indexPath, itemData:AnyHashable) -> UICollectionViewCell? in
        var cell:UICollectionViewCell!
        if let imageitemData = itemData.base as? ImagePostViewModel {


           let imageCell = collectionView.dequeueReusableCell(indexPath: indexPath, retrunType:ImageCollectionViewCell.self)




             if let url = URL(string: imageitemData.url) {
                imageCell.imageView.kf.setImage(with:url)
            }
            cell = imageCell

        }
        else if let suggestionData = itemData.base as? Suggestion{
            let suggestionsCell = collectionView.dequeueReusableCell(indexPath: indexPath, retrunType:SuggestionsItemsCell.self)
            suggestionsCell.suggestionLabel.text = suggestionData.name
            suggestionsCell.setNeedsLayout()
            suggestionsCell.layoutIfNeeded()
            cell = suggestionsCell
        }
        return cell
    }
    
    
    @IBOutlet var searchView: UISearchBar! {
        didSet {
            searchView.delegate = self
        }
    }
    
    @IBOutlet var colltionView: UICollectionView! {
        didSet{
            if let collectionView = colltionView {
                registerCellsTo(CollectionView: collectionView)

                self.dataSource = UICollectionViewDiffableDataSource<SectionViewModels, AnyHashable>(collectionView: collectionView, cellProvider:colletionViewDataMapper)
 
    

                collectionView.delegate = self
            }
            
        }
    }
    
    
    func registerCellsTo(CollectionView collectionView:UICollectionView){
        collectionView.registerReusableCell(ImageCollectionViewCell.self)
        collectionView.registerReusableCell(SuggestionsItemsCell.self)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiContoller = UnSplashServiceController()
    }


}




extension Sample2ViewController:UICollectionViewDelegate {
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == self.dataSource.snapshot().indexOfSection(.photos){
            if indexPath.row > (dataSource.snapshot().itemIdentifiers(inSection: .photos).count - 2) {
               self.apiContoller.loadMore()
            }
        }

    }
 

    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.section == self.dataSource.snapshot().indexOfSection(.suggestions){
            if let suggestion = self.dataSource.itemIdentifier(for:indexPath)?.base  as? Suggestion {
                self.searchView.searchTextField.text = suggestion.name
                self.fetchPhotos(for: suggestion.name)
            }
        }
        
    }

    
}

extension Sample2ViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.fetchPhotos(for: text)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.showSuggestions()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.hideSuggestion()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.dataSourceQueue.async {
        
        let newSuggestions = self.suggestions.filteredSuggestion(with: searchText)
//
//
//        var snapShot = NSDiffableDataSourceSnapshot<SectionViewModels,Suggestion>()
//
//        snapShot.appendSections([.suggestions])
//           snapShot.appendItems(newSuggestions, toSection: .suggestions)
//        self.dataSource.apply(snapShot)
//        self.dataSource.apply(snapShot, animatingDifferences: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        
        
        
       
            let hashable = newSuggestions.map { (suggestion) -> AnyHashable in
            return AnyHashable(suggestion)
            }
            var snapShot = self.dataSource.snapshot()
           
            if snapShot.sectionIdentifiers.contains(.suggestions) {
                snapShot.deleteItems(snapShot.itemIdentifiers(inSection: .suggestions))
            }
            else{
                if snapShot.sectionIdentifiers.contains(.photos){
                    snapShot.insertSections([.suggestions], beforeSection: .photos)
                }
                else{
                    snapShot.appendSections([.suggestions])
                }
            }
            
            snapShot.appendItems(hashable, toSection: .suggestions)
         self.dataSource.apply(snapShot)
      }
       
    }

}

extension Sample2ViewController{
    
    func showSuggestions(){
        self.dataSourceQueue.async {
//
//            var snapShot = NSDiffableDataSourceSnapshot<SectionViewModels,Suggestion>()
//
//            snapShot.appendSections([.suggestions])
            
        
            var snapShot = self.dataSource.snapshot()
            if  !snapShot.sectionIdentifiers.contains(.suggestions){
                           if let _ = snapShot.indexOfSection(.photos) {
                               snapShot.insertSections([.suggestions], beforeSection: .photos)
                           }else {
                               snapShot.appendSections([.suggestions])
                           }
                
                       
                       snapShot.appendItems(self.suggestions.filteredSuggestion(with: nil), toSection: .suggestions)
                           self.dataSource.apply(snapShot)
            }

       }
    }
    
    func hideSuggestion(){
       self.dataSourceQueue.async {
            var snapShot = self.dataSource.snapshot()
            snapShot.deleteSections([.suggestions])
            self.dataSource.apply(snapShot)
       }
    }
}


extension Sample2ViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let conatiner = self.dataSource.itemIdentifier(for: indexPath) else {
            return CGSize.zero
        }
        if indexPath.section == self.dataSource.snapshot().indexOfSection(.photos),let imageItems = conatiner.base as? ImagePostViewModel {
            
                let imageWidth = self.colltionView.contentSize.width
                let imageHeight = imageItems.getHeight(forContainerWidth: imageWidth)
                return CGSize(width: imageWidth,height: imageHeight)
        }else if indexPath.section == self.dataSource.snapshot().indexOfSection(.photos),let suggestionItem = conatiner.base as? Suggestion {
            let itemHeight:CGFloat = 31.0
            let itemWidth = suggestionItem.getContinerWidth(forHight: itemHeight)
            return CGSize(width: itemWidth, height: itemHeight)
            
            
        }
        return CGSize.zero
    }
}

// business logic



extension Sample2ViewController {
    func fetchPhotos(for searchTerm:String) {
        self.searchView.searchTextField.resignFirstResponder()
        self.clearCurrentResults()
        self.apiContoller.getPhotos(for: searchTerm)
    }
    
    func clearCurrentResults(){
        self.dataSourceQueue.async {
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteAllItems()
            self.dataSource.apply(snapshot)
       }
    }
}

