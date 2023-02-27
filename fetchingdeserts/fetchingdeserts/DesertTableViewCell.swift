//
//  DesertTableViewCell.swift
//  fetchingdeserts
//
//  Created by Odinaka Amadi on 2/27/23.
//

import UIKit

class DesertTableViewCell: UITableViewCell {
    
    static let reuseId = "\(DesertTableViewCell.self)"
    
    lazy var pokeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray5
        imageView.image = UIImage(named: "Image")
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
        }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Desert Name"
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {

        
        let hStack = UIStackView(axis: .horizontal, spacing: 8, distribution: .fillProportionally)
        let vStack = UIStackView(axis: .vertical, spacing: 8, distribution: .fillProportionally)
        
        vStack.addArrangedSubview(self.titleLabel)
        
        hStack.addArrangedSubview(self.pokeImageView)
        hStack.addArrangedSubview(vStack)
        
        self.contentView.addSubview(hStack)
        hStack.bindToSuperview()
    }
    
    
    
    
    func configure(desert: Meals) {
        self.titleLabel.text = desert.strMeal.capitalized
    }
    
}
