//
//  DiningHallListViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import UIKit

class DiningHallListViewController: UIViewController {
    @IBOutlet weak var diningHallTableView: UITableView!
    private var dataTask: URLSessionDataTask?
    
    var foods: [Food]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Dining Halls"
        diningHallTableView.delegate = self
        diningHallTableView.dataSource = self

        diningHallTableView.register(DiningHallTableViewCell.self, forCellReuseIdentifier: DiningHallTableViewCell.reuseIdentifier)

//        loadData(diningHall: "berkshire", menu: "dinner_menu")
    }
    
    @objc private func loadData(diningHall: String, menu: String, completion: @escaping () -> Void){
        guard let url = URL(string: "\(Constants.API.API_URL)api/foods/get/\(diningHall)/\(menu)") else {
            print("$ERROR: url not found")
            return
        }
                
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([Food].self, from: data)
                    DispatchQueue.main.async {
                        print("DATA: \(decodedData)")
                        State.shared.DiningFoods[diningHall]?[menu] = decodedData
                        print("DATA 2: \( State.shared.DiningFoods[diningHall]?[menu])")

                        completion()
                    }
            } catch let jsonError as NSError {
                print("$ERROR: \(jsonError)")
                print(String(describing: jsonError))
                print(jsonError.localizedDescription)
            }
        })
        dataTask?.resume()
    }
}

extension DiningHallListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return State.shared.diningHalls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let diningHall: DiningHall = State.shared.diningHalls[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: DiningHallTableViewCell.reuseIdentifier, for: indexPath) as? DiningHallTableViewCell {
            cell.diningHall = diningHall
            
            return cell
        }
        return UITableViewCell()
    }
}

extension DiningHallListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diningHall: DiningHall = State.shared.diningHalls[indexPath.row]
        loadData(diningHall: diningHall.key, menu: "lunch_menu") {
            self.performSegue(withIdentifier: "ToMealPlanViewController", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
