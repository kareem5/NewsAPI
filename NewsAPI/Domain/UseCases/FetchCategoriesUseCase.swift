//
//  FetchCategoriesUseCase.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 30/05/2022.
//

import Foundation
import Combine

protocol FetchCategoriesUseCaseInterface {
    func perform() -> AnyPublisher<[Category], Error>
}

final class FetchCategoriesUseCase: FetchCategoriesUseCaseInterface {
    
    private let newsRepository: NewsRepository
    
    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func perform() -> AnyPublisher<[Category], Error> {
        newsRepository.fetchCategories()
    }
}
