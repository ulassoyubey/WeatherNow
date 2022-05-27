//
//  BottomSheetInformationView.swift
//  WeatherNow
//
//  Created by ulas soyubey on 26.05.2022.
//

import UIKit

class BottomSheetInformationView: UIView {
    
    enum Constants:CGFloat {
        case padding = 5
    }
    
    let titleLabel = WeatherNowSecondaryLabel(fontSize: 20, textAligment: .center)
    let descLabel = WeatherNowTitleLabel(fontSize: 17, textAligment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configure(){
        addSubview(titleLabel)
        addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: Constants.padding.rawValue),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Constants.padding.rawValue),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 1),
            descLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: Constants.padding.rawValue),
            descLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Constants.padding.rawValue)
        ])
    }
    
    func setLabels(topLabelText:String,descLabelText:String){
        titleLabel.text = topLabelText
        descLabel.text = descLabelText
    }

}
