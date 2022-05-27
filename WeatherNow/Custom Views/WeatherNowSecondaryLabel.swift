//
//  WeatherNowSecondaryLabel.swift
//  WeatherNow
//
//  Created by ulas soyubey on 26.05.2022.
//

import UIKit

class WeatherNowSecondaryLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat,textAligment:NSTextAlignment) {
        self.init(frame: .zero)
        
        self.textAlignment = textAligment
        self.font = UIFont(name:"AvenirNextCondensed-Medium", size: fontSize)
    }
    
    private func configure(){
        textColor = .systemGray2
        self.translatesAutoresizingMaskIntoConstraints = false
        lineBreakMode = .byTruncatingTail
    }

}
