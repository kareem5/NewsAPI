//
//  MainCoordinator.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 21/05/2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let countriesLoadingService = CountriesLoader(fileName: "countries", fileType: "json")
        
        let newsRepository = NewsDataRepository(countriesLoadingService: countriesLoadingService,
                                                newsService: NewsAPIService())
        let fetchCountriesUseCase = FetchCountriesUseCase(newsRepository: newsRepository)
        let fetchTopHeadlinesUseCase = FetchTopHeadlinesUseCase(newsRepository: newsRepository)
        let fetchCategoriesUseCase = FetchCategoriesUseCase(newsRepository: newsRepository)
        let viewModel = NewsViewModel(fetchCountriesUseCase: fetchCountriesUseCase,
                                      fetchTopHeadlinesUseCase: fetchTopHeadlinesUseCase,
                                      fetchCategoriesUseCase: fetchCategoriesUseCase)
        let newsVC = NewsViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(newsVC, animated: false)
    }
    
    func newsDetails(with article: Article) {
        let viewModel =  NewsDetailsViewModel(with: article)
        let newsDetailsVC = NewsDetailsViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(newsDetailsVC, animated: true)
    }
    
}
