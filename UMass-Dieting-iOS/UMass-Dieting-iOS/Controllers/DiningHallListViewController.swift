//
//  DiningHallListViewController.swift
//  UMass-Dieting-iOS
//
//  Created by Vikram Singh on 11/12/22.
//

import UIKit

class DiningHallListViewController: UIViewController {

    @IBOutlet weak var diningHallTableView: UITableView!
    
    var foods: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Dining Halls"
        diningHallTableView.delegate = self
        diningHallTableView.dataSource = self
//        diningHallTableView.register(DiningHallTableViewCell.self, forCellReuseIdentifier: DiningHallTableViewCell.reuseIdentifier)
        // Do any additional setup after loading the view.
        diningHallTableView.register(DiningHallTableViewCell.self, forCellReuseIdentifier: DiningHallTableViewCell.reuseIdentifier)
        
        fetchFoodData()
        print(self.foods)
    }
    
    func fetchFoodData(){
        Task{
            do{
                if let foods = try await Sessions.loadFoodData(diningHall: "berkshire" , menu: "dinner_menu"){
                    self.foods = foods
                }
            } catch{
                return
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DiningHallListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return State.shared.diningHalls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("CELL FOR ROW AT CALLED")
        let diningHall: DiningHall = State.shared.diningHalls[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: DiningHallTableViewCell.reuseIdentifier, for: indexPath) as? DiningHallTableViewCell {
            cell.diningHall = diningHall
            
            return cell
        }
//        cell.diningHall = diningHall
        
        return UITableViewCell()
    }
}

extension DiningHallListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected dining hall!")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
