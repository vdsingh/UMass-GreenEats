//
//  DiningHallTableViewCell.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import UIKit

class DiningHallTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DiningHallTableViewCell"
    
    var diningHallTitleLabel: UILabel = {
        let diningHallTitleLabel = UILabel()
        diningHallTitleLabel.textColor = .white
        return diningHallTitleLabel
    }()
    
//    var hoursOfOperationLabel: UILabel = {
//        let hoursOfOperationLabel = UILabel()
//        hoursOfOperationLabel.textColor = .white
//        return hoursOfOperationLabel
//
//    }()
    
    var daysOfOperationLabel: UILabel = {
        let daysOfOperationLabel = UILabel()
        daysOfOperationLabel.textColor = .white
        return daysOfOperationLabel
    }()
    
    var diningHallImageView: UIImageView = {
        let diningHallImageView = UIImageView()
        diningHallImageView.translatesAutoresizingMaskIntoConstraints = false
        diningHallImageView.image = UIImage(named: "worcester_dining_hall.jpeg")
        diningHallImageView.layer.cornerRadius = 10
        diningHallImageView.clipsToBounds = true
        return diningHallImageView
    }()
    
    var infoStackView: UIStackView = {
        let infoStackView = UIStackView()
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.distribution = .fill
        infoStackView.alignment = .center
        infoStackView.spacing = 0
        return infoStackView
    }()
    
    var masterStackView: UIStackView = {
        let masterStackView = UIStackView()
        masterStackView.translatesAutoresizingMaskIntoConstraints = false
        masterStackView.axis = .vertical
        masterStackView.distribution = .fill
        masterStackView.backgroundColor = .systemBackground
        masterStackView.spacing = 0
        masterStackView.layer.cornerRadius = 10
        return masterStackView
    }()
    
    var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .blue
        container.layer.cornerRadius = 20
        return container
    }()
    
    var diningHall: DiningHall? {
        didSet {
            if let diningHall = diningHall {
                diningHallTitleLabel.attributedText = diningHall.name.withBoldText(text: diningHall.name, fontSize: 26)
                diningHallTitleLabel.textColor = UIColor(hexString: diningHall.colorHex)
                daysOfOperationLabel.text = "\(diningHall.daysOfOperation) from \(diningHall.hoursOfOperation)"
                daysOfOperationLabel.textColor = UIColor(hexString: diningHall.colorHex)
                
                diningHallImageView.image = UIImage(named: diningHall.imageName)
                
                container.backgroundColor = UIColor(hexString: diningHall.colorHex)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        
        contentView.addSubview(container)
        
        container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        container.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        container.addSubview(masterStackView)
        
        masterStackView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 15).isActive = true
        masterStackView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -15).isActive = true
        masterStackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
//        masterStackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -30).isActive = true
//        masterStackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 30).isActive = true
        
        masterStackView.addArrangedSubview(diningHallImageView)

        
        diningHallImageView.topAnchor.constraint(equalTo: masterStackView.topAnchor).isActive = true
        diningHallImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        diningHallImageView.widthAnchor.constraint(equalTo: masterStackView.widthAnchor).isActive = true
        diningHallImageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true

        
        masterStackView.addArrangedSubview(infoStackView)
        
        infoStackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        infoStackView.leftAnchor.constraint(equalTo: masterStackView.leftAnchor, constant: 20).isActive = true
        infoStackView.rightAnchor.constraint(equalTo: masterStackView.rightAnchor, constant: -20).isActive = true
//        infoStackView.topAnchor.constraint(equalTo: diningHallImageView.bottomAnchor, constant: 20).isActive = true
        infoStackView.bottomAnchor.constraint(equalTo: masterStackView.bottomAnchor, constant: 20).isActive = true
        
//        infoStackView.backgroundColor = .blue
        
        infoStackView.addArrangedSubview(diningHallTitleLabel)
//        infoStackView.addArrangedSubview(hoursOfOperationLabel)
        infoStackView.addArrangedSubview(daysOfOperationLabel)
        
//        diningHallTitleLabel.topAnchor.constraint(equalTo: diningHallImageView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
