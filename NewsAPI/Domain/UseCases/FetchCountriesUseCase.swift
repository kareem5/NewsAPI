//
//  FetchCountriesUseCase.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 23/05/2022.
//

import Foundation
import Combine

protocol FetchCountriesUseCaseInterface {
    func perform() -> AnyPublisher<CountriesList, Error>
}

final class FetchCountriesUseCase: FetchCountriesUseCaseInterface {
    
    private let newsRepository: NewsRepository
    
    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }
    
    func perform() -> AnyPublisher<CountriesList, Error> {
        newsRepository.fetchCountries()
    }
}
