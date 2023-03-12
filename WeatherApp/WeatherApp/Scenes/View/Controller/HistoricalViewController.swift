//
//  HistoricalViewController.swift
//  WeatherApp
//
//  Created by Fraghaly on 11/03/2023.
//

import UIKit

class HistoricalViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityName: UILabel!
    // MARK: - Properties
    lazy private var viewModel: HistoricViewModelLogic = {
        return HistoricViewModel()
    }()
    var city : City?
}
// MARK: - Life Cycle
extension HistoricalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
}
// MARK: - Setup UI
private extension HistoricalViewController{
    func setupUI() {
        cityName.text = "\(city?.name ?? "")\n historical".uppercased()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: HistoryTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: HistoryTableViewCell.identifier)
    }
    
    
}
// MARK: - Setup Binding
private extension HistoricalViewController {
    func setupBinding() {
        viewModel.reloadData = { [weak self] () in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
        }
        viewModel.emptyData = { [weak self] () in
            guard let self = self else {
                return
            }
            self.showAlert("There is no historic weather data")
        }
        viewModel.city = city
        viewModel.getWeatherList()
    }

}


// MARK: - TableView DataSource
extension HistoricalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath)
                as? HistoryTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }

        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.data = cellVM
        return cell
    }
}

// MARK: - Actions
extension HistoricalViewController {
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
