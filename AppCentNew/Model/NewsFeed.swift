//
//  NewsFeed.swift
//  AppCentNew
//
//  Created by ArifOk on 9.06.2021.
//

import Foundation

struct NewsFeed: Codable {
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article]?
}
