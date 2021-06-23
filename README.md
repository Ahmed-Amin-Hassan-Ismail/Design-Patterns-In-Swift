# Design-Patterns-In-Swift
📚 Fundamental Design Patterns

You can download from here 👇. 

[Design-Patterns.playground.zip](https://github.com/Ahmed-Amin-Hassan-Ismail/Design-Patterns-In-Swift.git)


```swift
print("Welcome!")
print("Lets Get Start 🤟")
```


Delegate Pattern
==========
>Delegate allows one object is perform specific task on behalf of another object

### When should you use it?

commenly use this pattern when you want to pass data back into previous screen, 
or in general use to lead specific object to perform some tasks on behalf of certain object

### Example:
```swift

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
```


Strategy Pattern
==========
>stategy pattern : a family of interchangeable objects that can be set or switched at runtime .

It separates into three main parts :-

1- strategy protocol: it defines the methods that every strategy must be implemented 

2- object using Strategy: mostly is view controller that interact with user 

3- strategies: "Scenarios" objects that confirms to strategy protocol


### When should you use it?

commenly use this pattern when have many different algorithms can be changed at runtime .  simply, "when you have many scenarios with your App and needs to select which scenario would prefere instead of building complex if - else statements in view controller we can use strategy pattern to perform each scenario separately and confirm strategy protocol then display on view controller 

### Example:

```swift

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
```

Singleton Pattern
==========
>signleton Pattern: is objects that have only one instance, then shared over the application, and every reference to the class refers to the same instance 

### When should you use it?

commenly use this pattern when you want a single instance through the all application such as singleton database , singleton application object , singleton fileManager. 

you can user it for modifing configuration around the whole application such as settings of its App , when use logging screen that logging uses for all the app 

### Example:

```swift
import Foundation
import UIKit

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
```

Memento Pattern
==========
>allows an object to be saved and restored (encoding and decoding)

### Consist of ? 

1- Originator : an object want to save

2- Memento: Data 

3- careTaker: is responsable for saving an object (encoding, Decoding)

### When should you use it?

commenly used if you want to save an object as persistent sate 

### Example:


```swift
import Foundation
import UIKit


// MARK: - Memento Pattern

/*
 image that you have a game and want to save your state
 sush as you level your score
 so you want to save it
 */

// Originator
class Game: Codable {
    
    enum State: Int {
        case level = 1
        case score = 0
    }
    
    func currentLevel() -> Int {
        return Game.State.level.rawValue
    }
    
    func currentScore() -> Int {
        return Game.State.score.rawValue
    }
}

// Memento
typealias MementoData = Data


// care taker
class GameState {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let userDefault = UserDefaults.standard
    
    func saveState(_ game: Game, title: String) throws {
        let data = try encoder.encode(game)
        userDefault.set(data, forKey: title)
    }
    
    func loadState(title: String) throws -> Game {
        guard let data = userDefault.value(forKey: title) as? Data,
            let game = try? decoder.decode(Game.self, from: data) else {
                throw Errors.gameNotFound
        }
        return game
    }
}
enum Errors: String, Error {
    case gameNotFound = "Your State Not Found!"
}
```

Delegate Pattern
==========
>let's one objecr to observe on another object.

### How to use? 

There are Three ways to make an observation :-  

1- KVO (Key-Value-Observation) uses Objective-C  "import Foundation"

2- With Native Swift ( didSet , willSet )

3- Your own Observable wrapper class 


### When should you use it?

commenly use when you want to observe about property does it change 

### Example:


```swift
import Foundation
import UIKit

// MARK: - Observer Patther

// MARK: - 1. KVO ( Key - value - observation )

/*
 KVO : uses objective-c
 this method is leading to observe the property itself at run time
*/

// 1

@objcMembers class UsersObjectiveC: NSObject {
    dynamic var name: String
    init(name: String) {
        self.name = name
        super.init()
    }
}
let userName = UsersObjectiveC(name: "Ahmed")
var KVOserver: NSKeyValueObservation = userName.observe(\.name,options: [.new]) { (user, change) in
    print("User's name is \(user.name)")
}
userName.name = "Amin"

// MARK: -/////////////////////////////////////////////////////////

// MARK: - with native swift ( didSet , willSet )

// 2

class UsersSwift {
    var name: String {
        didSet {
            // when change the name it will be invoked
            print("Hey i am changed with new name")
        }
    }
    init(name: String) {
        self.name = name
    }
}

let user1 = UsersSwift(name: "Ahmed")
user1.name = "Amin"
```

