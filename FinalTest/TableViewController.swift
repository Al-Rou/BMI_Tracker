//
//  TableViewController.swift
//  FinalTest
//
//  Created by Sorena Sorena on 2021-12-17.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var infos: [Info]! = []
    var userDefaults = UserDefaults.standard
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        infos = []
        fillTableView()
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        infos = []
        fillTableView()
    }*/

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return infos == nil ? 0 : infos.count
    }
    
    func fillTableView(){
        
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        
        do{
            let aux = userDefaults.data(forKey: "Info")!
            infos = try decoder.decode([Info].self, from: aux)
            
            /*var insertedDate = ""
            let date = Date()
            let calendar = Calendar.current
            
            insertedDate += String(calendar.component(.year, from: date)) + "/" + String(calendar.component(.month, from: date)) + "/" + String(calendar.component(.day, from: date))*/
            
            /*let zeroInfo = Info(id: 0, name: "Alex", age: 25, gender: "male", system: "Metric", height: 1.84, weight: 125, bmi: 36.9, date: insertedDate)
            infos.append(zeroInfo)
            let zeroInfo1 = Info(id: 1, name: "John", age: 25, gender: "male", system: "Imperial", height: 70, weight: 198, bmi: 28.4, date: insertedDate)
            infos.append(zeroInfo1)
            let zeroInfo2 = Info(id: 2, name: "Josie", age: 25, gender: "female", system: "Metric", height: 1.65, weight: 155, bmi: 40.2, date: insertedDate)
            infos.append(zeroInfo2)
            let zeroInfo3 = Info(id: 3, name: "Kim", age: 25, gender: "female", system: "Imperial", height: 62, weight: 140, bmi: 25.6, date: insertedDate)
            infos.append(zeroInfo3)*/
        }
        catch{
            print("Unable to decode: (\(error))")
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Showinfo", for: indexPath)
        
        if (((infos[indexPath.row] as Info).system == "Metric")&&(((infos[indexPath.row] as Info).id != 0))){
        cell.textLabel?.text = "weight: " +  String((infos[indexPath.row] as Info).weight) + "kg" + "\t" + "BMI: " +  String((infos[indexPath.row] as Info).bmi) + "\t" + "\t" + (infos[indexPath.row] as Info).date
        }else if (((infos[indexPath.row] as Info).system == "Imperial")&&(((infos[indexPath.row] as Info).id != 0))){
            cell.textLabel?.text = "weight: " +  String((infos[indexPath.row] as Info).weight) + "lb" + "\t" + "BMI: " +  String((infos[indexPath.row] as Info).bmi) + "\t" + "\t" + (infos[indexPath.row] as Info).date
        }
        
        cell.isUserInteractionEnabled = true
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
