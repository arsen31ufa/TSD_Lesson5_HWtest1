//
//  ViewController.swift
//  TSD_Lesson5_HW
//
//  Created by Арсен Рахимов on 18.10.2024.
//

import UIKit
// библ чтобы обращаться к биометрическим функциям
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
    }
    @IBAction func enterFaceID(_ sender: Any) { // в info.plist добавить row Privacy – Face ID Usage Description и указать причину
        if (sender as AnyObject).isOn {
            //контекст, обеспечивающий взаимодействие между приложением и биометрическими функциями
            let context = LAContext()
            //переменная с типом NSError, которая опционально будет хранить ошибки. из библ LocalAuthentication
            var error: NSError?
            //проверяем, есть ли у пользователя техническая возможность провести биометрическую аутентификацию
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Идентифицируйте себя"
                //запускаем процесс аутентификации, передавая в один из аргументов переменную reason, которая будет в себе хранить причину, по которой Вы запрашиваете биометрию
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in
                    
                    if success {
                        //метод, позволяющий работать с многопоточностью приложения, в данном случае он позволяет нам перейти к основному потоку и объявить пользователю об успешной авторизации
                        DispatchQueue.main.async { [unowned self] in
                            // загрузка Storyboard
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            // загрузка View Controller и его сцены со Storyboard
                            let viewController = storyboard.instantiateViewController(identifier:
                            "VC2")
                            //show(viewController, sender: nil)
                            // отображение сцены на экране
                            viewController.modalPresentationStyle = .fullScreen
                            self.present(viewController, animated: true, completion: nil)
                        }
                    }
                }
                
            } else {
                print("Face/Touch ID не найден")
            }
        }
    }
    @IBAction func eyePassword(_ sender: Any) {
        if passwordTextField.isSecureTextEntry == true {
            passwordTextField.isSecureTextEntry = false
        } else if  passwordTextField.isSecureTextEntry == false {
                passwordTextField.isSecureTextEntry = true
            }
        }
    @IBAction func enterButton(_ sender: Any) {
        let sign = signIn(email: emailTextField.text, password: passwordTextField.text)
    
        if sign {
            // загрузка Storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // загрузка View Controller и его сцены со Storyboard
            let viewController = storyboard.instantiateViewController(identifier:
            "VC2")
            //show(viewController, sender: nil)
            // отображение сцены на экране
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func signIn(email: String?, password: String?) -> Bool{
        if email == "111" && password == "222" {
            return true
        } else {
            let signInAlert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel)
                signInAlert.addAction(cancelAction)
            present(signInAlert, animated: true)
            return false
        }
        
    }
    
}


