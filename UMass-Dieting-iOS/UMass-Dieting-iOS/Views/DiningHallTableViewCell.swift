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
    
    var hoursOfOperationLabel: UILabel = {
        let hoursOfOperationLabel = UILabel()
        hoursOfOperationLabel.textColor = .white
        return hoursOfOperationLabel
        
    }()
    
    var daysOfOperationLabel: UILabel = {
        let daysOfOperationLabel = UILabel()
        daysOfOperationLabel.textColor = .white
        return daysOfOperationLabel
    }()
    
    var infoStackView: UIStackView = {
        let infoStackView = UIStackView()
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillProportionally
        infoStackView.alignment = .leading
        infoStackView.spacing = 0
        return infoStackView
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
            diningHallTitleLabel.attributedText = diningHall?.name.withBoldText(text: diningHall?.name ?? "", fontSize: 22)
            hoursOfOperationLabel.text = diningHall?.hoursOfOperation
            daysOfOperationLabel.text = diningHall?.daysOfOperation
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        super.awakeFromNib()
        
        contentView.addSubview(container)
        
        container.addSubview(infoStackView)
        
        infoStackView.addArrangedSubview(diningHallTitleLabel)
        infoStackView.addArrangedSubview(hoursOfOperationLabel)
        infoStackView.addArrangedSubview(daysOfOperationLabel)
        
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        infoStackView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 20).isActive = true
        infoStackView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        container.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        container.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        container.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
//    override func awakeFromNib() {
//
//    }
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
