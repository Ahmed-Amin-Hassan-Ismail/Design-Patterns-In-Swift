
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

