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
    var selectedDiningHall: DiningHall? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Dining Halls"
        diningHallTableView.delegate = self
        diningHallTableView.dataSource = self

        diningHallTableView.register(DiningHallTableViewCell.self, forCellReuseIdentifier: DiningHallTableViewCell.reuseIdentifier)

//        loadData(diningHall: "berkshire", menu: "dinner_menu")
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MealPlanViewController {
            guard let selectedDiningHall = self.selectedDiningHall else {
                fatalError("$ERROR: Selected dining hall is nil")
            }
            destination.diningHall = selectedDiningHall
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDiningHall = State.shared.diningHalls[indexPath.row]
        guard let selectedDiningHall = self.selectedDiningHall else {
            fatalError("$ERROR: Selected dining hall is nil")
        }
        
        Sessions.loadFoodData(diningHall: selectedDiningHall.key, menu: "lunch_menu") {
            self.performSegue(withIdentifier: "ToMealPlanViewController", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
