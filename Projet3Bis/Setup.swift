//
//  Setup.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class Setup {
    var player1 = Player()
    var player2 = Player()
    var isPlayer2: Bool = false
    
    func setupGame() {
        createPlayer(player: player1)
        createCharacter(player: player1)
        createPlayer(player: player2)
        createCharacter(player: player2)
    }
    
    private func createPlayer(player: Player) {
        if isPlayer2 {
            print("Hello, choose a name for your player 2")
        } else {
            print("Hello, choose a name for your player 1")
        }
        let name = readLine()
        if name!.count < 3 {
            print("your Player must have 3 letters in his name")
            createPlayer(player: player)
        } else {
            player.name = name!
            isPlayer2 = true
            if isPlayer2 {
                if player2.name.capitalized == player1.name.capitalized {
                    print("You can't choose the same name that Player 1")
                    createPlayer(player: player)
                }
            }
        }
    }
    
    private func createCharacter(player: Player) {
        if player.characters.count == 0 {
            print("Choose a name for your first Character")
        } else if player.characters.count == 1 {
            print("Choose a name for your second Character")
        } else {
            print("Choose a name for your third Character")
        }
        chooseName(player: player)
    }
    
    private func chooseName(player: Player) {
        if let name = readLine(), !name.isEmpty {
            var sameName = 0
            if name.count < 3 {
                print("your Character must have 3 letters in his name")
                chooseName(player: player)
            }
            if player.characters.count == 0 {
                    chooseRace(name: name)
            } else {
                for index in 0...player.characters.count-1 where name.capitalized == player.characters[index].name.capitalized {
                    sameName += 1
                }
                if sameName > 0 {
                    print("your Character can't have the same name of another Character")
                    sameName = 0
                    chooseName(player: player)
                } else {
                    chooseRace(name: name)
                }
            }
        }
    }
        
    private func chooseRace(name: String) {
            print("Choose a Race for \(name)")
        }


}
