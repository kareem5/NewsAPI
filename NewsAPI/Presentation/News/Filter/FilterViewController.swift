//
//  FilterViewController.swift
//  NewsAPI
//
//  Created by Kareem Ahmed on 30/05/2022.
//

import UIKit
import Combine

class FilterViewController: UIViewController, UITableViewDelegate {
    
    enum Section: String, CaseIterable {
        case country = "Select Country"
        case category = "Select Category"
    }

    @IBOutlet
    private weak var tableView: UITableView!
    @IBOutlet
    private weak var okayButton: UIButton!
    
    private lazy var dataSource = makeDataSource()
    private let viewModel: NewsViewModel
    private var subscriptions = Set<AnyCancellable>()
    private let cellIdentifier = "FilterCell"
    
    var selectedFilters: (Country, Category)?

    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "FilterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindUI()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = dataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedFilters = viewModel.selectedFilters
    }
    
    private func setupUI() {
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        okayButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    private func bindUI() {
        viewModel.$filters
            .sink { [unowned self] countries, categories in
                self.updateData(with: countries, categories: categories)
            }.store(in: &subscriptions)
    }

    // MARK: - TableView
    private func makeDataSource() -> DataSource {
        let myDatasource =
        DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .country:
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
                guard let country = itemIdentifier as? Country else { fatalError("Cannot create country cell")}
                
                var content = cell.defaultContentConfiguration()
                content.text = country.name
                cell.contentConfiguration = content
                cell.accessoryType = country == self.selectedFilters?.0 ? .checkmark : .none
                cell.selectionStyle = .none
                return cell
            case .category:
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
                guard let category = itemIdentifier as? Category else { fatalError("Cannot create category cell")}
                
                var content = cell.defaultContentConfiguration()
                content.text = category.rawValue
                cell.contentConfiguration = content
                cell.accessoryType = category == self.selectedFilters?.1 ? .checkmark : .none
                cell.selectionStyle = .none
                return cell
            }
            
        }
                
        return myDatasource
    }
    
    private func updateData(with countries: CountriesList, categories: [Category]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        snapshot.appendSections([Section.country, Section.category])
        snapshot.appendItems(countries, toSection: .country)
        snapshot.appendItems(categories, toSection: .category)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = Section.allCases[indexPath.section]
        switch sectionType {
        case .country:
            selectedFilters?.0 = viewModel.filters.0[indexPath.row]
        case .category:
            selectedFilters?.1 = viewModel.filters.1[indexPath.row]
        }
        
        tableView.reloadData()
    }
    
    @IBAction private func okayButtonAction(_ sender: UIButton) {
        viewModel.didUpdateFilters(category: selectedFilters!.1,
                                   country: selectedFilters!.0)
        dismiss(animated: true, completion: nil)
    }
    
}


class DataSource: UITableViewDiffableDataSource<FilterViewController.Section, AnyHashable>  {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return FilterViewController.Section.allCases[section].rawValue
        }
}
