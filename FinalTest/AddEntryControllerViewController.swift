//
//  AddEntryControllerViewController.swift
//  FinalTest
//
//  Created by Sorena Sorena on 2021-12-17.
//

import UIKit
import DropDown

class AddEntryControllerViewController: UIViewController {
    
    @IBOutlet weak var editWeight: UITextField!
    @IBOutlet weak var showEnteredDate: UILabel!
    @IBOutlet weak var unitSys: UILabel!
    var day : String = ""
    var month : String = ""
    var year : String = ""
    var isMetric : Bool = true
    var userDefaults = UserDefaults.standard
    private var infos : [Info]! = []
    
    let menuDay: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
        menu.backgroundColor = .red
        menu.selectedTextColor = .blue
        menu.textFont = .boldSystemFont(ofSize: 12)
        return menu
    }()
    let menuMonth: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        menu.backgroundColor = .red
        menu.selectedTextColor = .blue
        menu.textFont = .boldSystemFont(ofSize: 12)
        return menu
    }()
    let menuYear: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008", "2007", "2006", "2005"]
        menu.backgroundColor = .red
        menu.selectedTextColor = .blue
        menu.textFont = .boldSystemFont(ofSize: 12)
        return menu
    }()

    @IBAction func selectDay(_ sender: UIButton) {
        menuDay.show()
    }
    @IBAction func selectMonth(_ sender: UIButton) {
        menuMonth.show()
    }
    @IBAction func selectYear(_ sender: UIButton) {
        menuYear.show()
    }
    
    @IBAction func buttonUpdate(_ sender: UIButton) {
        
        if ((self.showEnteredDate.text == "")||(self.editWeight.text == "")){
            var dialogMessage = UIAlertController(title: "Warning", message: "No Field could be left blank!", preferredStyle: .alert)
             
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
            dialogMessage.addAction(ok)
             self.present(dialogMessage, animated: true, completion: nil)
        }else{
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()
            do{
                var whatIsHeightMetric : Float = 1
                var whatIsHeightImperial : Float = 1
            let aux = userDefaults.data(forKey: "Info")!
            infos = try decoder.decode([Info].self, from: aux)
                
                let newBmi : Float?
                
                
                if ((infos[infos.count-1] as Info).date == "today"){
                    var dialogMessage = UIAlertController(title: "Warning", message: "First, save at least one entry in the table!", preferredStyle: .alert)
                     
                     let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                         print("Ok button tapped")
                      })
                    dialogMessage.addAction(ok)
                     self.present(dialogMessage, animated: true, completion: nil)
                }else if ((infos[infos.count-1] as Info).system == "Metric"){
                    whatIsHeightMetric = (infos[infos.count-1] as Info).height
                    whatIsHeightImperial = (39.3701)*whatIsHeightMetric
                }else if ((infos[infos.count-1] as Info).system == "Imperial"){
                    whatIsHeightImperial = (infos[infos.count-1] as Info).height
                    whatIsHeightMetric = (0.0254)*whatIsHeightImperial
                }
                let addedInfo : Info
                if (isMetric){
                    newBmi = round(10*(Float(editWeight.text!)!/(whatIsHeightMetric*whatIsHeightMetric)))/10
                    addedInfo = Info(id: ((infos[infos.count-1] as Info).id)+1, name: (infos[infos.count-1] as Info).name, age: (infos[infos.count-1] as Info).age, gender: (infos[infos.count-1] as Info).gender, system: "Metric", height: (infos[infos.count-1] as Info).height, weight: Float(editWeight.text!)!, bmi: newBmi!, date: showEnteredDate.text!)
                }else if (!isMetric){
                    newBmi = round(10*(Float(editWeight.text!)!*703/(whatIsHeightImperial*whatIsHeightImperial)))/10
                    addedInfo = Info(id: ((infos[infos.count-1] as Info).id)+1, name: (infos[infos.count-1] as Info).name, age: (infos[infos.count-1] as Info).age, gender: (infos[infos.count-1] as Info).gender, system: "Imperial", height: (infos[infos.count-1] as Info).height, weight: Float(editWeight.text!)!, bmi: newBmi!, date: showEnteredDate.text!)
                }
                else{
                    addedInfo = infos[infos.count-1] as Info
                }
                infos.append(addedInfo)
                let addedEntry = try encoder.encode(infos)
                userDefaults.set(addedEntry, forKey: "Info")
                
            }catch{
                print("Unable to decode: (\(error))")
            }
        }
    }
    
    @IBAction func unitSystem(_ sender: UISwitch) {
        if (!sender.isOn){
            unitSys.text = "Imperial"
            self.editWeight.placeholder = "weight in pound"
            isMetric = false
        }else{
            unitSys.text = "Metric"
            self.editWeight.placeholder = "weight in kilogram"
            isMetric = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureDay = UITapGestureRecognizer(target: self, action: #selector(selectDay))
        gestureDay.numberOfTapsRequired = 1
        gestureDay.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gestureDay)
        
        menuDay.selectionAction = {index, title in
            self.day = title
        }
        
        let gestureMonth = UITapGestureRecognizer(target: self, action: #selector(selectMonth))
        gestureMonth.numberOfTapsRequired = 1
        gestureMonth.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gestureMonth)
        
        menuMonth.selectionAction = {index, title in
            self.month = title
        }
        
        let gestureYear = UITapGestureRecognizer(target: self, action: #selector(selectYear))
        gestureYear.numberOfTapsRequired = 1
        gestureYear.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gestureYear)
        
        menuYear.selectionAction = {index, title in
            self.year = title
            
            if ((self.day == "")||(self.month == "")||(self.year == "")){
                self.showEnteredDate.text = "Choose a complete date!"
            }else{
            let assemble : String = self.year + "/" + self.month + "/" + self.day
            self.showEnteredDate.text = assemble
            }
        }
        
        
    }

}
