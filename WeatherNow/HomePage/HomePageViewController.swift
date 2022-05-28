//
//  HomePageViewController.swift
//  WeatherNow
//
//  Created by ulas soyubey on 20.05.2022.
//

import UIKit

protocol HomePageViewProtocol:AnyObject {
    
    var presenter:HomePagePresenter? { get set }
    
    func configureNavBar(cityName:String)
    func setWeatherLabel(weatherData:String)
    func setWeatherDescription(weatherDescription:String)
    func configureBottomContainer()
    func configureStackView()
    func setWindFieldText(topLabelText:String,descLabelText:String)
    func setHumidityFieldText(topLabelText:String,descLabelText:String)
    func setVisibilityTextFiled(topLabelText: String, descLabelText: String)
    func updateImage()
    func configureCollectionView()
}

class HomePageViewController: UIViewController,HomePageViewProtocol {
    
    let weatherLabel = WeatherNowTitleLabel(fontSize: 45, textAligment: .center)
    let weatherDescLabel = WeatherNowSecondaryLabel(fontSize: 30, textAligment: .center)
    let grayContainerView = UIView()
    let todayLabel = WeatherNowTitleLabel(fontSize: 25, textAligment: .left)
    let informationStackView = UIStackView()
    let windKpHField = BottomSheetInformationView()
    let humidityField = BottomSheetInformationView()
    let visibilityField = BottomSheetInformationView()
    let weatherImage = WeatherImageView(frame: .zero)
    var forecastCollectionView:UICollectionView!
    var presenter: HomePagePresenter?
        

    override func viewDidLoad() {
        super.viewDidLoad()

        //updateCurrentWeatherData()
        view.backgroundColor = .white
        presenter?.viewDidLoad()
        setImage()

    }
    
    func configureNavBar(cityName:String) {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = cityName
        navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 30) ??
                                         UIFont.systemFont(ofSize: 30)]
    }
            
    func setWeatherLabel(weatherData:String){
        view.addSubview(weatherLabel)
        weatherLabel.text = weatherData
        NSLayoutConstraint.activate([
            weatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 160)
        ])
    }
    
    func setWeatherDescription(weatherDescription: String) {
        view.addSubview(weatherDescLabel)
        weatherDescLabel.text = weatherDescription
        NSLayoutConstraint.activate([
            weatherDescLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherDescLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor)
        ])
    }
    
    func setImage(){
        view.addSubview(weatherImage)
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 50),
            weatherImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            weatherImage.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            weatherImage.bottomAnchor.constraint(equalTo: weatherLabel.topAnchor)
        ])
    }
    
    func configureBottomContainer() {
        view.addSubview(grayContainerView)
        grayContainerView.addSubview(todayLabel)
        todayLabel.text = "Today"
        todayLabel.translatesAutoresizingMaskIntoConstraints = false
        grayContainerView.translatesAutoresizingMaskIntoConstraints = false
        grayContainerView.layer.cornerRadius = 20
        grayContainerView.backgroundColor = .systemGray6
        NSLayoutConstraint.activate([
            grayContainerView.topAnchor.constraint(equalTo: weatherDescLabel.bottomAnchor, constant: 100),
            grayContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            grayContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            grayContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant:-5),
            todayLabel.topAnchor.constraint(equalTo: grayContainerView.topAnchor,constant: 15),
            todayLabel.leadingAnchor.constraint(equalTo: grayContainerView.leadingAnchor,constant: 15)
        ])
    }
    
    func updateImage() {
        weatherImage.downloadImage(fromUrl: presenter?.getImageUrl() ?? "")
    }
    
    func configureStackView() {
        grayContainerView.addSubview(informationStackView)

        informationStackView.alignment = .fill
        informationStackView.axis = .horizontal
        informationStackView.distribution = .fillEqually
        informationStackView.backgroundColor = .clear
    
        
        informationStackView.addArrangedSubview(windKpHField)
        informationStackView.addArrangedSubview(humidityField)
        informationStackView.addArrangedSubview(visibilityField)

        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor,constant: 15),
            informationStackView.leadingAnchor.constraint(equalTo: grayContainerView.leadingAnchor,constant: 5),
            informationStackView.trailingAnchor.constraint(equalTo: grayContainerView.trailingAnchor,constant: 5),
            informationStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setWindFieldText(topLabelText:String,descLabelText:String){
        windKpHField.setLabels(topLabelText: topLabelText, descLabelText: descLabelText)
    }
    func setHumidityFieldText(topLabelText: String, descLabelText: String) {
        humidityField.setLabels(topLabelText: topLabelText, descLabelText: descLabelText)
    }
    
    func setVisibilityTextFiled(topLabelText: String, descLabelText: String) {
        visibilityField.setLabels(topLabelText: topLabelText, descLabelText: descLabelText)
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        forecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
        layout.scrollDirection = .horizontal
        forecastCollectionView.backgroundColor = .clear
        forecastCollectionView.showsHorizontalScrollIndicator = false
        forecastCollectionView.register(ForecastCellCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCellCollectionViewCell.reuseId)
        view.addSubview(forecastCollectionView)
        forecastCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastCollectionView.topAnchor.constraint(equalTo: informationStackView.bottomAnchor, constant: 20),
            forecastCollectionView.leadingAnchor.constraint(equalTo: grayContainerView.leadingAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: grayContainerView.trailingAnchor),
            forecastCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }


}

extension HomePageViewController:UICollectionViewDelegate {
    
}

extension HomePageViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width / 3) - 40, height: 100)
    }

}

extension HomePageViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = presenter?.getForecastCount() {
            return count
        }else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCellCollectionViewCell.reuseId, for: indexPath) as! ForecastCellCollectionViewCell
        if let allday = presenter?.getWeatherAtIndex(index: indexPath.item) {
            cell.setCells(forecast: allday)
        }
        return cell
    }
}
