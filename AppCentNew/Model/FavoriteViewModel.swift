//
//  FavoriteViewModel.swift
//  AppCentNew
//
//  Created by ArifOk on 16.06.2021.
//

import Foundation

struct FavoritesModel{
    
    public static var shared = FavoritesModel(articles: [])
    
    var articles: [Article]
    
}
