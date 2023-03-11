//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import UIKit
protocol WeatherInfo: AnyObject{
    func getCity(name: String)
}
class AddCityViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    weak var delegate: WeatherInfo?
    lazy private var viewModel: WeatherViewModelLogic = {
        return WeatherViewModel()
    }()
}

// MARK: - Life Cycle
extension AddCityViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI
private extension AddCityViewController{
    func setupUI() {
        setupTableView()
        hideKeyboard()
        searchBar.delegate = self
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: CityTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
   
}



// MARK: - Setup Binding
private extension AddCityViewController {
    func setupBinding() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }

        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    print("stoploading")
                case .loading:
                    print("loading")
                case .populated:
                    print("stoploading")
                }
            }
        }
        viewModel.reloadData = { [weak self] () in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
        }
        viewModel.getWeather(name: searchBar.text ?? "")
    }

}

// MARK: - TableView DataSource
extension AddCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath)
                as? CityTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.searchData = cellVM.cityName
        return cell
    }
}

// MARK: - TableView Delegate
extension AddCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getCity(name: viewModel.getCellViewModel( at: indexPath ).cityName)
        dismiss(animated: true)

    }
}

// MARK: - TableView Delegate
extension AddCityViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty ?? false) {
            setupBinding()
        }
    }
}
