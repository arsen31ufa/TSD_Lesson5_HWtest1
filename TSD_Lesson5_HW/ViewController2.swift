//
//  ViewController2.swift
//  TSD_Lesson5_HW
//
//  Created by Арсен Рахимов on 18.10.2024.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var nameLabelView2: UILabel!
    @IBOutlet weak var orderLabelView2: UILabel!
    @IBOutlet weak var daysLabelView2: UILabel!
    //var nameVC2 = "Имя клиента"
    //var orderVC2 = "Инфо о заказе"
    //var daysVC2 = "0 дней"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameLabelView2.text = nameVC2
        //orderLabelView2.text = orderVC2
        //daysLabelView2.text = daysVC2
    }
    @IBAction func closeScene(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? ViewController3 else {
            return }
        viewController.infoToVC2 = self
    }
    func update(name: String, days: Date, inst: String) {
        nameLabelView2.text = name
        daysLabelView2.text = inst
        
        //let newDate = days
        let differenceInDays = Calendar.current.dateComponents([.day], from: days, to: .now).day
        orderLabelView2.text = differenceInDays!.description + " дней"
    }
    
    

   

}
