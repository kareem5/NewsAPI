//
//  NewsDataRepository.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 21/05/2022.
//

import Foundation
import Combine

final class NewsDataRepository: NewsRepository {
    
    private let countriesLoadingService: CountriesLoaderInterface
    private let newsService: NewsAPIServiceInterface
    
    
    init(countriesLoadingService: CountriesLoaderInterface,
         newsService: NewsAPIServiceInterface) {
        self.countriesLoadingService = countriesLoadingService
        self.newsService = newsService
    }
    
    func fetchTopHeadlines(with country: Country, category: Category?) -> AnyPublisher<TopHeadlines, Error> {
        newsService.fetchTopHeadlines(with: country, category: category)
    }
    
    func fetchCountries() -> AnyPublisher<CountriesList, Error> {
        countriesLoadingService.loadCountries()
    }
    
    func fetchCategories() -> AnyPublisher<[Category], Error> {
        Just(Category.allCases).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
