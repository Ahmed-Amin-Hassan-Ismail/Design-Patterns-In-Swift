
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



