
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

