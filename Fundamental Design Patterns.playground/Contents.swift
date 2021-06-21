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


//MARK:-----------------------------------------------------------------------------------------

// MARK: - Strategy Pattern

/*
 consider that you have several services that present
 1- plain users ---> Users API
 2- plain employess ---> Employes API
 
 instead of writing each of these services in if - else statmets it does not make sense.
 so we will 3 objects each object is responsable for each API through comfirming Strategy protocol and in view controller can switch between them easly
 */

// 1
protocol ServiceStrategy {
    
    var serviceName: String { get }
    
    func getService(name: String, completion: @escaping (_ success: String, _ failure: String) -> Void)
    
}

// 2 different objects

class plainUSersService: ServiceStrategy {
    
    var serviceName: String {
        return "User Service"
    }
    
    func getService(name: String, completion: @escaping (String, String) -> Void) {
        
        // Doing Network cell to get users services
        let success = "sccuessful get users from service."
        let failute = "opps, something went wrong whereas getting data"
        completion(success, failute)
    }
}

class plainEmployessService: ServiceStrategy {
    
    var serviceName: String {
        return "Employee Service"
    }
    
    func getService(name: String, completion: @escaping (String, String) -> Void) {
        // Doing Network cell to get users services
        let success = "sccuessful get employess from service."
        let failute = "opps, something went wrong whereas getting data"
        completion(success, failute)
    }
}

// 3
class viewController: UITableViewController {
    
    /*
     consider in this view have
     1- segmented controll to switch over users and employees
     2- tableview to present data of each one
     */
    
    private var strategy: ServiceStrategy?
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBAction func segmentedAction(_ segmented: UISegmentedControl) {
        
        switch segmented.selectedSegmentIndex {
        case 0 :
            strategy = plainUSersService()
            tableView.reloadData()
        case 1:
            strategy = plainEmployessService()
            tableView.reloadData()
        default:
            fatalError()
        }
    }
}

//MARK:-----------------------------------------------------------------------------------------

// MARK: - Singleton Pattern

/*
 consider that you create setting screen for your app
 you have a listed of data in tableview and you have
 option in setting that display this data either sequential data or random data
 */

class AppSetting {
    
    static let shared = AppSetting()
    
    private init() { }
    
}




