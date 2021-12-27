//
//  ViewController.swift
//  FinalTest
//
//  Created by Sorena Sorena on 2021-12-16.
//

import UIKit
import DropDown

struct Info : Codable{
    let id : Int
    let name : String
    let age : Int
    let gender : String
    let system : String
    let height : Float
    let weight : Float
    let bmi : Float
    let date : String
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblAge: UITextField!
    @IBOutlet weak var lblGender: UITextField!
    @IBOutlet weak var lblHeight: UITextField!
    @IBOutlet weak var lblWeight: UITextField!
    @IBOutlet weak var showBmiResult: UILabel!
    @IBOutlet weak var showBmiClass: UILabel!
    @IBOutlet weak var systemName: UILabel!
    var isMetric : Bool = true
    var bmiResultFloat : Float?
    var lastId : Int = 0
    

    var listOfInfo : [Info] = []
    var userDefaults = UserDefaults.standard
    let zeroInfo = Info(id: 0, name: "Sexy", age: 25, gender: "female", system: "Metric", height: 1.65, weight: 55, bmi: 20.2, date: "today")
    
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["male", "female"]
        menu.backgroundColor = .red
        menu.selectedTextColor = .blue
        menu.textFont = .boldSystemFont(ofSize: 38)
        return menu
    }()
    
    @IBAction func changePlaceHolders(_ sender: UISwitch) {
        if (!sender.isOn){
            systemName.text = "Imperial"
            lblHeight.placeholder = "height in inch"
            lblWeight.placeholder = "weight in pound"
            isMetric = false
        }else{
            systemName.text = "Metric"
            lblHeight.placeholder = "height in meter"
            lblWeight.placeholder = "weight in kilogram"
            isMetric = true
        }
    }
    @IBAction func buttonCalcul(_ sender: UIButton) {
        
        let enteredName : String = self.lblName.text!
        let enteredAge : String = self.lblAge.text!
        let enteredGender : String = self.lblGender.text!
        let numberOfWeight : Float? = Float(self.lblWeight.text!)
        let numberOfHeight : Float? = Float(self.lblHeight.text!)
        
        if ((numberOfWeight == nil)||(numberOfHeight == nil)||(enteredName == "")||(enteredAge == "")||(enteredGender == "")){
            showBmiResult.text = "Fields with asterisks cannot be left blank!"
            showBmiClass.text = ""
            
            var dialogMessage = UIAlertController(title: "Warning", message: "Fields with asterisks cannot be left blank!", preferredStyle: .alert)
             
             let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                 print("Ok button tapped")
              })
            dialogMessage.addAction(ok)
             self.present(dialogMessage, animated: true, completion: nil)
            
        }else{
            if ((enteredGender != "male")&&(enteredGender != "female")){
                showBmiResult.text = "Entered Gender is not valid!"
                showBmiClass.text = ""
                
                var dialogMessage = UIAlertController(title: "Warning", message: "Select your gender just from the provided menu!", preferredStyle: .alert)
                 
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                  })
                dialogMessage.addAction(ok)
                 self.present(dialogMessage, animated: true, completion: nil)
            }else{
        if(isMetric){
            bmiResultFloat = numberOfWeight!/(numberOfHeight!*numberOfHeight!)
            bmiResultFloat = round(10*bmiResultFloat!)/10
        }else{
            bmiResultFloat = (numberOfWeight!*703)/(numberOfHeight!*numberOfHeight!)
            bmiResultFloat = round(10*bmiResultFloat!)/10
        }
        let bmiResult : String = String(bmiResultFloat!)
        showBmiResult.text = "Your BMI is " + bmiResult
        
        if (bmiResultFloat! < 16.0){
            showBmiClass.text = "You have severe thinness!"
        }else if ((bmiResultFloat! >= 16.0)&&(bmiResultFloat! < 17.0)){
            showBmiClass.text = "You have moderate thinness!"
        }else if ((bmiResultFloat! >= 17.0)&&(bmiResultFloat! < 18.5)){
            showBmiClass.text = "You have mild thinness!"
        }else if ((bmiResultFloat! >= 18.5)&&(bmiResultFloat! < 25.0)){
            showBmiClass.text = "Your weight is normal!"
        }else if ((bmiResultFloat! >= 25.0)&&(bmiResultFloat! < 30.0)){
            showBmiClass.text = "You have overweight!"
        }else if ((bmiResultFloat! >= 30.0)&&(bmiResultFloat! < 35.0)){
            showBmiClass.text = "You are in Obese ClassI!"
        }else if ((bmiResultFloat! >= 35.0)&&(bmiResultFloat! < 40.0)){
            showBmiClass.text = "You are in Obese ClassII!"
        }else if (bmiResultFloat! >= 40.0){
            showBmiClass.text = "You are in Obese ClassIII!"
        }
        }
        }
    }
    @IBAction func buttonReset(_ sender: UIButton) {
        self.lblName.text = ""
        self.lblAge.text = ""
        self.lblGender.text = ""
        self.lblHeight.text = ""
        self.lblWeight.text = ""
        showBmiResult.text = ""
        showBmiClass.text = ""
    }
    func idCounter() -> Int{
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do{
            let aux = userDefaults.data(forKey: "Info")!
            listOfInfo = try decoder.decode([Info].self, from: aux)
            lastId = (listOfInfo[listOfInfo.count-1] as Info).id
            return lastId
        }
        catch{
            print("Unable to encode: (\(error))")
            return 0
        }
    }
    
    @IBAction func buttonSave(_ sender: UIButton) {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        var insertedDate = ""
        let date = Date()
        let calendar = Calendar.current
        
        insertedDate += String(calendar.component(.year, from: date)) + "/" + String(calendar.component(.month, from: date)) + "/" + String(calendar.component(.day, from: date))
        
        listOfInfo.append(zeroInfo)
        do{
            let zeroEntry = try encoder.encode(listOfInfo)
            userDefaults.set(zeroEntry, forKey: "Info")
        }catch{
            print("Unable to encode: (\(error))")
        }
        let newInfo : Info
        
        if (isMetric){
            newInfo = Info(id: idCounter()+1, name: lblName.text!, age: Int(lblAge.text!)!, gender: lblGender.text!, system: "Metric", height: Float(lblHeight.text!)!, weight: Float(lblWeight.text!)!, bmi: bmiResultFloat!, date: insertedDate)
        }else{
            newInfo = Info(id: idCounter()+1, name: lblName.text!, age: Int(lblAge.text!)!, gender: lblGender.text!, system: "Imperial", height: Float(lblHeight.text!)!, weight: Float(lblWeight.text!)!, bmi: bmiResultFloat!, date: insertedDate)
        }
        
        do{
            let aux = userDefaults.data(forKey: "Info")!
            listOfInfo = try decoder.decode([Info].self, from: aux)
            listOfInfo.append(newInfo)
            
            let entry = try encoder.encode(listOfInfo)
            userDefaults.set(entry, forKey: "Info")
        }
        catch{
            print("Unable to encode: (\(error))")
        }
    }
    @IBAction func buttonBmiTracker(_ sender: UIButton) {
        
        
    }
    
    @IBAction func selectGenderButton(_ sender: UIButton) {
        menu.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectGenderButton))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(gesture)
        
        menu.selectionAction = {index, title in
            self.lblGender.text = title
        }
    }


}

