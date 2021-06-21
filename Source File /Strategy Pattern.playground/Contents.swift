
import Foundation
import UIKit

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
