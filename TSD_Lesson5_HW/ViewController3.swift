//
//  ViewController3.swift
//  TSD_Lesson5_HW
//
//  Created by Арсен Рахимов on 18.10.2024.
//

import UIKit

class ViewController3: UIViewController {
    
    weak var infoToVC2 : ViewController2?
    
    @IBOutlet weak var FIOTextField: UITextField!
    
    let agePicker = UIPickerView()
    @IBOutlet weak var ageTextField: UITextField!
    
    let sexPicker = UIPickerView()
    @IBOutlet weak var sexTextField: UITextField!
    
    let orderDatePicker = UIDatePicker()
    @IBOutlet weak var orderDateTextField: UITextField!
    
    @IBOutlet weak var instaTextField: UITextField!
    
    let arrayGender = ["Мужской", "Женский"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPicker()
        
        agePicker.tag = 1
        ageTextField.inputView = agePicker
        
        sexPicker.tag = 2
        sexTextField.inputView = sexPicker
        
        createDatePicker()
        
        orderDatePicker.locale = .init(identifier: "Russian")
        orderDatePicker.preferredDatePickerStyle = .wheels
        
        instaTextField.addTarget(self, action: #selector(createInstAlert), for: .allEditingEvents)
        
        // класс будет подписан на протокол
        agePicker.dataSource = self
        agePicker.delegate = self
        sexPicker.dataSource = self
        sexPicker.delegate = self
        
        
    }
    @IBAction func closeScene(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addClient(_ sender: Any) {
        //Кнопка добавления клиента
        //передаем инфу на VC2
        infoToVC2?.update(name: FIOTextField.text!, days: orderDatePicker.date, inst: instaTextField.text!)
        
        self.dismiss(animated: true, completion: nil)
    }
    func createPicker() {
        let toolbarPicker = UIToolbar()
        // подстроить размер под содержимое
        toolbarPicker.sizeToFit()
        let doneButtonToolbar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonAge))
        toolbarPicker.setItems([doneButtonToolbar], animated: true)
        ageTextField.inputAccessoryView = toolbarPicker
        sexTextField.inputAccessoryView = toolbarPicker
        
    }
    @objc func doneButtonAge() {
        //завершение редактирования. Скрытие окна/клавиатуры
        view.endEditing(true)
        //ageTextField.resignFirstResponder()
    }
   
    func createDatePicker() {
        let toolbarPicker = UIToolbar()
        // подстроить размер под содержимое
        toolbarPicker.sizeToFit()
        let doneButtonToolbar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePickerButtonToolbar))
        toolbarPicker.setItems([doneButtonToolbar], animated: true)
        // добавляет над пикером панель инструментов с кнопкой Done
        orderDateTextField.inputAccessoryView = toolbarPicker
        // добавлять  дейт пикер как средство ввода
        orderDateTextField.inputView = orderDatePicker
        orderDatePicker.datePickerMode = .date
        
    }
    @objc func doneDatePickerButtonToolbar() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        //formatter.timeZone = .none
        
        //Перевод на русский
        formatter.locale = .init(identifier: "Russian")
        
        orderDateTextField.text = formatter.string(from: orderDatePicker.date)
        
        view.endEditing(true)
    }
    @objc func createInstAlert (){
        let instAlert = UIAlertController(title: "Instagram", message: "Введите никнейм", preferredStyle: .alert)
        let goAction = UIAlertAction(title: "Ок", style: .default) { (action) in
            self.instaTextField.text = instAlert.textFields?[0].text
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        instAlert.addTextField { (textField) in
            textField.placeholder = "Введите свой никнейм"
        }
        instAlert.addAction(goAction)
        instAlert.addAction(cancelAction)
        self.present(instAlert, animated: true)
    }
        
        

}
extension ViewController3 : UIPickerViewDataSource {
        //кол-во компонентов в пикере
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // кол-во строк в компоненте
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return 100
        case 2: return 2
        default: return 1
        }
        }
    }

extension ViewController3 : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1: return "\(row)"
        case 2: return arrayGender[row]
        default: return "\(row)"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1: ageTextField.text = "\(row)"
        case 2: sexTextField.text = arrayGender[row]
       
        default: return
        }
    }
}
