//
//  NewsRepository.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 21/05/2022.
//

import Combine

protocol NewsRepository {
    func fetchTopHeadlines(with country: Country, category: Category?) -> AnyPublisher<TopHeadlines, Error>
    func fetchCountries() -> AnyPublisher<CountriesList, Error>
    func fetchCategories() -> AnyPublisher<[Category], Error>
}
