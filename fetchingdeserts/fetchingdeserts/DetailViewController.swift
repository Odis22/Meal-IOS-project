//
//  DetailViewController.swift
//  fetchingdeserts
//
//  Created by Odinaka Amadi on 2/27/23.
//

import UIKit


class DetailViewController: UIViewController {
    
    
    var indexP = 0
    //static  let reuseID = "\(PokiTableViewCell.self)"

        lazy var pokeImageViewX: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .systemGray
            imageView.image = UIImage(named: "Image")
            imageView.layer.masksToBounds = false
            imageView.backgroundColor = .white
            // imageView.layer.borderColor = .white
            imageView.layer.cornerRadius = 141
            imageView.clipsToBounds = true
            return imageView
            }()

        lazy var progLabel: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 40
            label.font = UIFont.systemFont(ofSize: 25)
            label.textAlignment = .center
            label.backgroundColor = .systemGray6
            return label
        }()

        lazy var progLabel2: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 10
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            label.backgroundColor = .systemGray5
            return label
        }()

        lazy var progLabel3: UILabel = {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 40
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            label.backgroundColor = .systemGray4
            return label
        }()
    var mealId: String?
    var mealDetails = [Details]()
 let network = NetworkManager()
    var Hght: String = ""
    var Wght: String = ""
    var BExp: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        fetchMealDetail()
        self.setUpUI()
    }
    func fetchMealDetail() {
        guard let mealId = mealId else { return }
// API Call
        NetworkManager.shared.fetchPage2(mealId: mealId) { details in

// Using compactMap to filter out nil values
            self.mealDetails = details.meals.compactMap { $0 }
            self.configureData(desertDetails: details.meals)
            print("DEBUG: \(details.meals[0].getIngredients())")
            }

        }

    private func setUpUI(){
        self.view.addSubview(self.pokeImageViewX)
        self.view.addSubview(self.progLabel)
        self.view.addSubview(self.progLabel2)
        self.view.addSubview(self.progLabel3)
            let vStackView = UIStackView(frame: .zero)
            vStackView.translatesAutoresizingMaskIntoConstraints = false
            vStackView.spacing = 8
            vStackView.axis = .vertical
            vStackView.distribution = .equalSpacing
        vStackView.setDimensions(width: self.view.bounds.width - 40, height: self.view.bounds.height - 10)
            vStackView.addArrangedSubview(self.progLabel)
            vStackView.addArrangedSubview(self.progLabel2)
            vStackView.addArrangedSubview(self.progLabel3)
            
            let hStackView = UIStackView(frame: .zero)
            hStackView.translatesAutoresizingMaskIntoConstraints = false
            hStackView.spacing = 8
            hStackView.axis = .vertical
        
            
            hStackView.addArrangedSubview(self.pokeImageViewX)
            hStackView.addArrangedSubview(vStackView)
            
            self.pokeImageViewX.heightAnchor.constraint(equalToConstant: 200).isActive = true
            self.pokeImageViewX.widthAnchor.constraint(equalToConstant: 200).isActive = true
            
            self.view.addSubview(hStackView)
        hStackView.bindToSuperview()
        
        }
    
    func configureData(desertDetails: [Details]) {
        DispatchQueue.main.async {
            let url = URL(string: desertDetails[0].strMealThumb)
            guard let url = url else { return }
   
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                 // Error handling...
                 guard let imageData = data else { return }

                 DispatchQueue.main.async {
                     let image = UIImage(data: imageData)
                     self.pokeImageViewX.image = image
                 }
               }.resume()
            self.progLabel.text = desertDetails[0].strMeal
            self.progLabel2.text =  (desertDetails[0].getIngredients())
            self.progLabel3.text = desertDetails[0].strInstructions
            print(desertDetails[0].strInstructions)
        }
    }
}
extension UIView {
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
