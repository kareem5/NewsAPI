//
//  NewsAPITests.swift
//  NewsAPITests
//
//  Created by Kareem Ahmed on 20/05/2022.
//

import XCTest
import Combine
@testable import NewsAPI

class NewsAPITests: XCTestCase {
    
    var sut: NewsRepository!
    var newsApiService: NewsAPIServiceMock!
    var subscriptions = Set<AnyCancellable>()

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        newsApiService = NewsAPIServiceMock()
        let countriesLoadingService = CountriesLoader(fileName: "countries", fileType: "json")
        sut = NewsDataRepository(countriesLoadingService: countriesLoadingService,
                                 newsService: NewsAPIService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
