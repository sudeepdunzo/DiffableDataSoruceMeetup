//
//  SuggestionController.swift
//  CollectionViewDiffableDatasource
//
//  Created by SUDEEP KINI on 15/10/19.
//  Copyright © 2019 scud. All rights reserved.
//

import Foundation




let suggestionsRawData = "love,instagood,fashion,beautiful,happy,tbt,ocean,summer,art,time,france,friends,nature,girl,fun,style,smile,food,family,travel,likeforlike,fitness,life,beauty,amazing,sun,music,beach,oot,sunset,sunrise,dog,sky,vsco,makeup,foodporn,hair,pretty,cat,model,swag,motivation,party,baby,cool,gym,lol,design,funny,healthy,christmas,night,lifestyle,yummy,flowers,hot,handmade,wedding,fit,black,pink,blue,workout,work,blackandwhite,drawing,inspiration,holiday,home,london,nyc,mumbai,sea,winter,goodmorning,blessed,rio,germany,india,nothern lights"







class SuggestionsController {
    
    func filteredSuggestion(with filter: String?) -> [Suggestion] {
        return mountains.filter { $0.contains(filter) }
    }
    private lazy var mountains: [Suggestion] = {
        return generateMountains()
    }()
}

extension SuggestionsController {
    private func generateMountains() -> [Suggestion] {
        let components = suggestionsRawData.components(separatedBy: ",")
        let suggestions = components.map { (suggestionString) -> Suggestion in
            return Suggestion(name:suggestionString)
        }
        return suggestions
    }
}




private extension Suggestion {
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}

