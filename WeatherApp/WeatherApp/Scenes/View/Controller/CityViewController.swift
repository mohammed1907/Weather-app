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
        viewModel.getCities()
    }

}

extension CityViewController{
    @IBAction func addCityPressed(_ sender: Any) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AddCityViewController.identifier) as! AddCityViewController
        controller.delegate = viewModel
        self.present(controller, animated: true)
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
        cell.searchData = cellVM.name
        return cell
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteCityAction(indexPath: indexPath)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - TableView Delegate
extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Navigate to details
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: WeatherDetailsViewController.identifier) as! WeatherDetailsViewController
        controller.city = viewModel.getCellViewModel( at: indexPath )
        self.present(controller, animated: true)
        //TODO: Handle coreData
        
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //TODO: Navigate to historic weather
    }
    
}
//MARK: Handle swipe
extension CityViewController{
    private func deleteCityAction(indexPath: IndexPath) {
        let city = viewModel.cityArray?[indexPath.row]
      let areYouSureAlert = UIAlertController(title: "Are you sure you want to delete this city?", message: "", preferredStyle: .alert)
      let yesDeleteAction = UIAlertAction(title: "Yes", style: .destructive) { [self] (action) in
        DataManager.shared.deleteCity(city: city!)
        viewModel.cityArray?.remove(at: indexPath.row)
      }
      let noDeleteAction = UIAlertAction(title: "No", style: .default) { (action) in
        //do nothing
      }
      areYouSureAlert.addAction(noDeleteAction)
      areYouSureAlert.addAction(yesDeleteAction)
      self.present(areYouSureAlert, animated: true, completion: nil)
    }
}
