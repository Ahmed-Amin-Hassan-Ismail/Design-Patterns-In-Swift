
import Foundation
import UIKit


// MARK: - Delegate Pattern


/*
 Imagine that you have two screens (A) and (B)
 and screen A is responsable to present data on tableView
 and screen B is responsable to lead the user add his data by static table
 so how to pass data back into screen A to present his data?
 BY (Delegation pattern)
 where Screen A: is a delegate of screen B to help it that present its data
 
 let get handy into play to see
 */

// User Data Model
class UserModel {
    var id: String?
    var name: String?
    var email: String?
}

// is resonsable to present data on TableView
class ScreenA: UITableViewController, ScreenBDelegate {
    
    var usersData = [UserModel]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addUser" {
            let controller = segue.destination as! ScreenB
            controller.delegate = self
        }
    }
    
    // Confirm to screen B Protocol
    func ScreenB(_ controller: ScreenB, didAdd user: UserModel) {
        usersData.append(user)
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}

// 1
protocol ScreenBDelegate: class {
    func ScreenB(_ controller: ScreenB, didAdd user: UserModel)
}



// is responsable for add user Data
class ScreenB: UITableViewController {
    
    /* imagine you have static tableView
     have textField to add user's id, name and email
     after that he press into submit button to present via screen A
     and navigate into screen A
     */
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //2
    weak var delegate: ScreenBDelegate?
    
    @IBAction func submitButton(_ sender: UIButton) {
        // add user
        let newUser = UserModel()
        newUser.id = idTextField.text!
        newUser.name = nameTextField.text!
        newUser.email = emailTextField.text!
        
        //3
        delegate?.ScreenB(self, didAdd: newUser)
        
    }
}

