//
//  FetchTopHeadlinesUseCase.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 21/05/2022.
//

import Foundation
import Combine

protocol FetchTopHeadlinesUseCaseInterface {
    func perform(with country: Country, category: Category?) -> AnyPublisher<TopHeadlines, Error>
}

final class FetchTopHeadlinesUseCase: FetchTopHeadlinesUseCaseInterface {
    
    private let newsRepository: NewsRepository
    
    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func perform(with country: Country, category: Category?) -> AnyPublisher<TopHeadlines, Error> {
        newsRepository.fetchTopHeadlines(with: country, category: category)
    }
}
