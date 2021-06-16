//
//  NewsModel.swift
//  AppCentNew
//
//  Created by ArifOk on 9.06.2021.
//

import Foundation
import Alamofire

protocol NewsServiceResponse {
    
    func serviceResponseSucces()
    func serviceResponseFailure()
    
}

struct ServiceConstant {
    static let END_POINT = "https://newsapi.org/v2/everything?"
    static let API_KEY = "apiKey=873cfce39d554c5d851e863a8f4df624"
    static let SEARCH_CRITERIA = "q="
    static let PAGE = "page"
}


class NewsViewModel {
    
    var delegate: NewsServiceResponse
    var newsFeed: NewsFeed?
    
    init(delegate: NewsServiceResponse) {
        self.delegate = delegate
    }
    
    
    func getRequestAPICall(searchCriteria: String, page: Int){
        
        let todosEndpoint: String = getURL(searchCriteria, page)
    
        Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { [weak self] response in
                debugPrint(response)
                
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    self?.newsFeed = try decoder.decode(NewsFeed.self, from: data)
                    self?.delegate.serviceResponseSucces()
                } catch let error {
                    self?.delegate.serviceResponseFailure()
                }
            }
    }
    
    
    func getURL(_ searchCriteria: String,_ page: Int) -> String{
        return ServiceConstant.END_POINT + ServiceConstant.SEARCH_CRITERIA + "\(searchCriteria)"
            + "&" + ServiceConstant.PAGE + "\(page)" + "&" + ServiceConstant.API_KEY
    }
}
