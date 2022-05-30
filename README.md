# NewsAPI

It's an iOS project which displaying a list of uptodate news using **News API** and allows the user to filter the news by category and country then display more details about the specific news article.

The project is built using **MVVM-C architecture** where **M** represents **Model** to hold the data entities, **VM** represents **ViewModel** to handle the flow and work with the different services, **V** represents **View** to hold the UI, **C** represents **Coordinator** to handle the navigation and passing data between different modules and it's built with using **Clean Architecture** to keep the SOLID principle applied and make the project scalable.
It's using combine framework to apply observer pattern.
It's built by applying clean architecture by using use cases, repositories to deal with the services.


## List of Modules
1. **News List** handling the process of fetching the news list and retrieve the news data from the APIs, displaying that list to UI.
2. **News Details** displaying the news details
## Technologies

Project is created using:

* **MVVM-C** Architecture
* **Combine** framework
* **Clean Architecture**
* iOS SDK **14.0**
* Swift version **5.0**
* XCode version **13.2.1**

## Third-Party libraries
**Kingfisher** which is used for fetching and caching images with lazy loading.

### Test Cases

* Repository Test cases:
