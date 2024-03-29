//
//  Sample1ViewController.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 18/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import UIKit

class Sample1ViewController: UIViewController {
    
    private var suggestions = SuggestionsController()
    
    private var colletionViewDataMapper:(UICollectionView, IndexPath, Suggestion) -> UICollectionViewCell? = { (collectionView, indexPath, itemData:Suggestion) -> UICollectionViewCell? in
        
    
        
        let suggestionsCell = collectionView.dequeueReusableCell(indexPath: indexPath, retrunType:SuggestionsItemsCell.self)
            suggestionsCell.suggestionLabel.text = itemData.name

        return suggestionsCell
    }

    private  var dataSource: UICollectionViewDiffableDataSource<SectionViewModels, Suggestion>! = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    @IBOutlet var colltionView: UICollectionView! {
        didSet{
            
            if let collectionView = colltionView {
                            registerCellsTo(CollectionView: collectionView)
                
              
                
                    self.dataSource = UICollectionViewDiffableDataSource<SectionViewModels,Suggestion>(collectionView: collectionView, cellProvider:colletionViewDataMapper)
            }
        }
        
            
    }
    
    @IBOutlet var searchView: UISearchBar! {
           didSet {
               searchView.delegate = self
           }
       }
    
    
    
    func registerCellsTo(CollectionView collectionView:UICollectionView){
    collectionView.registerReusableCell(SuggestionsItemsCell.self)
    
    }
    
}


extension Sample1ViewController {
    
    func showSuggestions(){
           
        var snapShot = NSDiffableDataSourceSnapshot<SectionViewModels,Suggestion>()
    
        snapShot.appendSections([.suggestions])
    snapShot.appendItems(self.suggestions.filteredSuggestion(with: nil), toSection: .suggestions)
        self.dataSource.apply(snapShot)
        
    }

    func hideSuggestion(){
        var snapShot = self.dataSource.snapshot()
        snapShot.deleteSections([.suggestions])
        self.dataSource.apply(snapShot)
           
    }

}



extension Sample1ViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // do nothing
        self.searchView.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.showSuggestions()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.hideSuggestion()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let newSuggestions = self.suggestions.filteredSuggestion(with: searchText)
        
        var snapShot = NSDiffableDataSourceSnapshot<SectionViewModels,Suggestion>()

        snapShot.appendSections([.suggestions])
           snapShot.appendItems(newSuggestions, toSection: .suggestions)
        self.dataSource.apply(snapShot)
      
    }

    
}
