//
//  ViewController.swift
//  fetchingdeserts
//
//  Created by Odinaka Amadi on 2/27/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
   lazy var mealtable: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
       table.delegate = self
       table.backgroundColor = .white
       table.register(DesertTableViewCell.self, forCellReuseIdentifier: DesertTableViewCell.reuseId)
        return table
    }()
    var deserts: [Meals] = []
    var Ptypes = [Details]()
    var typeCache: [Int:String] = [:]
    let indeXM = 0
    let network: NetworkManager = NetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setUpUI()
        
        self.view.backgroundColor = .white
        self.title = "Desert Menu"
        //Nachalo
            self.network.fetchPage(urlStr: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") { result in
            switch result {
            case .success(let page):
             //   print(page)
            self.deserts = page.meals
                DispatchQueue.main.async {
            self.mealtable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        }
    private func setUpUI() {
        self.view.addSubview(self.mealtable)
        self.mealtable.bindToSuperview()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deserts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DesertTableViewCell.reuseId, for: indexPath) as? DesertTableViewCell else {
        return UITableViewCell()
        }
        cell.configure(desert: self.deserts[indexPath.row])
        DispatchQueue.main.async {
            let url = URL(string: self.deserts[indexPath.row].strMealThumb)
            guard let url = url else { return }
     
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                 // Error handling...
                 guard let imageData = data else { return }

                 DispatchQueue.main.async {
                     let image = UIImage(data: imageData)
                     cell.pokeImageView.image = image
                 }

               }.resume()

        }
    return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
        detailVC.mealId = deserts[indexPath.row].idMeal
        
    }
}

