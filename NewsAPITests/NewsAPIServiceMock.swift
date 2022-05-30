//
//  NewsAPIServiceMock.swift
//  NewsAPITests
//
//  Created by Kareem Ahmed on 30/05/2022.
//

import Foundation
import Combine
@testable import NewsAPI

final class NewsAPIServiceMock: NewsAPIServiceInterface {
    
    var topHeadlines: TopHeadlines?
    func fetchTopHeadlines(with country: Country, category: Category?) -> AnyPublisher<TopHeadlines, Error> {
        
    }
    
}
