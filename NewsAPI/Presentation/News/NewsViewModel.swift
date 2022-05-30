//
//  NewsViewModel.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 21/05/2022.
//

//import Foundation
import Combine

final class NewsViewModel {
    private let fetchCountriesUseCase: FetchCountriesUseCaseInterface
    private let fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCaseInterface
    private let fetchCategoriesUseCase: FetchCategoriesUseCaseInterface
    
    @Published private(set) var filters: (CountriesList, [Category]) = ([], [])
    @Published private(set) var articles: [Article] = []
    @Published private(set) var state: ViewState = .loading
    private var subscriptions = Set<AnyCancellable>()
    
    var selectedFilters: (Country, Category)?
    
    var defaultFilters: (Country, Category) {
        return (filters.0.first(where: { $0.iso2?.lowercased() == "us" })!, Category.allNews)
    }
    
    var newsListTitle: String {
        selectedFilters?.1 == .allNews ? "All News" : selectedFilters?.1.rawValue ?? "All News"
    }
    init(fetchCountriesUseCase: FetchCountriesUseCaseInterface,
         fetchTopHeadlinesUseCase: FetchTopHeadlinesUseCaseInterface,
         fetchCategoriesUseCase: FetchCategoriesUseCaseInterface) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
        self.fetchTopHeadlinesUseCase = fetchTopHeadlinesUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
    }
    
    func viewDidLoad() {
        fetchFilters()
//        fetchCategories()
    }
    
    func fetchTopHeadlines() {
        articles.removeAll()
        fetchTopHeadlinesUseCase.perform(with: selectedFilters!.0, category: selectedFilters!.1)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("error: \(error)")
                    self.state = .error(message: ViewModelError.faildTopHeadlinesLoading.message)
                }
            } receiveValue: {[unowned self] topHeadlines in
                guard let receivedArticles = topHeadlines.articles else { return }
                self.articles = receivedArticles
                self.state = .success
            }.store(in: &subscriptions)

    }
    
    private func fetchFilters() {
        fetchCountriesUseCase.perform()
            .combineLatest(fetchCategoriesUseCase.perform())
            .sink { completion in
                if case .failure(let error) = completion {
                    print("error: \(error)")
                    self.state = .error(message: ViewModelError.faildFiltersLoading.message)
                }
            } receiveValue: { countries, categories in
                self.filters = (countries, categories)
                self.selectedFilters = self.defaultFilters
                self.fetchTopHeadlines()
            }.store(in: &subscriptions)

    }
    
    func didUpdateFilters(category: Category, country: Country) {
        selectedFilters?.0 = country
        selectedFilters?.1 = category
        fetchTopHeadlines()
    }
    
    enum ViewModelError: Error {
        case faildFiltersLoading
        case faildTopHeadlinesLoading
        
        var message: String {
            switch self {
            case .faildFiltersLoading:
                return "Failed to load Filters"
            case .faildTopHeadlinesLoading:
                return "Failed to load top headlines from API"
            }
        }
    }
    
}
