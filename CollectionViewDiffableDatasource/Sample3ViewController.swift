//
//  Sample3ViewController.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 18/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import UIKit
import DiffableDataSources





class Sample3ViewController: UIViewController {
    
    private var suggestions = SuggestionsController()
    
    private var colletionViewDataMapper:(UICollectionView, IndexPath, Suggestion) -> UICollectionViewCell? = { (collectionView, indexPath, itemData:Suggestion) -> UICollectionViewCell? in
        
    
        
        let suggestionsCell = collectionView.dequeueReusableCell(indexPath: indexPath, retrunType:SuggestionsItemsCell.self)
            suggestionsCell.suggestionLabel.text = itemData.name

        return suggestionsCell
    }

    private  var dataSource: CollectionViewDiffableDataSource<SectionViewModels, Suggestion>! = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    @IBOutlet var colltionView: UICollectionView! {
        didSet{
            
            if let collectionView = colltionView {
                            registerCellsTo(CollectionView: collectionView)
                
              
                
                    self.dataSource = CollectionViewDiffableDataSource<SectionViewModels,Suggestion>(collectionView: collectionView, cellProvider:colletionViewDataMapper)
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


extension Sample3ViewController {
    
    func showSuggestions(){
           
        var snapShot = DiffableDataSourceSnapshot<SectionViewModels,Suggestion>()
    
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



extension Sample3ViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // do nothing
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.showSuggestions()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.hideSuggestion()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let newSuggestions = self.suggestions.filteredSuggestion(with: searchText)
        
        var snapShot = DiffableDataSourceSnapshot<SectionViewModels,Suggestion>()

        snapShot.appendSections([.suggestions])
           snapShot.appendItems(newSuggestions, toSection: .suggestions)
        self.dataSource.apply(snapShot)
      
    }

    
}
