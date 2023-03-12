//
//  WeatherDetailsViewController.swift
//  WeatherApp
//
//  Created by Farghaly on 11/03/2023.
//

import UIKit
import Kingfisher
class WeatherDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherTemprature: UILabel!
    @IBOutlet weak var weatherHumidity: UILabel!
    @IBOutlet weak var weatherWind: UILabel!
    
    @IBOutlet weak var weatherDate: UILabel!
    
    // MARK: - Properties
    lazy private var viewModel: WeatherDetailsViewModelLogic = {
        return WeatherDetailsViewModel()
    }()
    var city : City?
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - Life Cycle
extension WeatherDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.dropShadow()
    }
    
}

// MARK: - Setup UI
private extension WeatherDetailsViewController{
    func setupUI() {
        cityTitle.text = city?.name?.uppercased()
    }


}



// MARK: - Setup Binding
private extension WeatherDetailsViewController {
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
            if let data = self.viewModel.weatherDataInfo{
                self.setupWeatherData(data: data)
            }
        }
        viewModel.city = city
        viewModel.getWeatherList()
        viewModel.getWeather(name: city?.name ?? "")
    }
    func setupWeatherData(data: WeatherInfoViewModel){
        if let url = URL(string:data.iconImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""){
               weatherImage.kf.setImage(with: url)
           }
        weatherDescription.text = data.weatherStatus
        weatherTemprature.text = data.weatherTemp
        weatherWind.text = data.wind
        weatherHumidity.text = data.humidity
        weatherDate.text = "WEATHER INFORMATION FOR \(city?.name?.uppercased() ?? "") RECEIVED ON \(data.weatherTime)"
    }

}


