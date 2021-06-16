//
//  Article.swift
//  AppCentNew
//
//  Created by ArifOk on 9.06.2021.
//

import Foundation

struct Article: Codable, Equatable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
}
