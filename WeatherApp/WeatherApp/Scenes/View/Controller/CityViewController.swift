//
//  ViewController.swift
//  WeatherApp
//
//  Created by Farghaly on 10/03/2023.
//

import UIKit

class CityViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    lazy private var viewModel: CityViewModelLogic = {
        return CityViewModel()
    }()
}
// MARK: - Life Cycle
extension CityViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
}
// MARK: - Setup UI
private extension CityViewController{
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: CityTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    
}
// MARK: - Setup Binding
private extension CityViewController {
    func setupBinding() {
        viewModel.reloadData = { [weak self] () in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
        }
    }

}

extension CityViewController: WeatherInfo{
    @IBAction func addCityPressed(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AddCityViewController.identifier) as! AddCityViewController
        controller.delegate = self
        self.present(controller, animated: true)
    }
    
    func getCity(name: String) {
        viewModel.cityArray?.append(name)
    }
    
    
}
// MARK: - TableView DataSource
extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath)
                as? CityTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.accessoryType = .detailDisclosureButton

        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.searchData = cellVM
        return cell
    }
}

// MARK: - TableView Delegate
extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Navigate to details
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: WeatherDetailsViewController.identifier) as! WeatherDetailsViewController
        controller.cityName = viewModel.getCellViewModel( at: indexPath )
        self.present(controller, animated: true)
        //TODO: Handle coreData
        
    }
}
