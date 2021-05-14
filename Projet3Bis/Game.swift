//
//  Game.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class Game {
    enum State {
        case isOngoing
        case isOver
    }
    var state: State = .isOngoing
    var totalTurn: Int = 1
    var winner: Player?
    let player1: Player
    let player2: Player
    let randomChest = RandomChest()
    let currentPArray : [Player]
    let characterArray: [Character]
    var currentPIndex = 0
    var currentC: Character?
    var currentP: Player
    var currentTarget: Character?
    var currentAction: String = ""
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.currentP = player1
        self.characterArray = player1.characters + player2.characters
        self.currentPArray = [player1, player2]
    }
    
    func start() {
        print("Get ready to Fight!")
        turn()
        }
    
    func stats() {
        
    }
    
    
    func checkHealCharacter(player: Player, indexCurrentCharac: Int, coop1: Int, coop2: Int) {
        if currentC == player.characters[indexCurrentCharac] {
            if currentP.name == player1.name {
                if currentC!.race.health < currentC!.race.healthMax {
                    
                }
                if checkHealth(player, coop1) > 0 && checkHealth(player, coop1) < player.characters[coop1].race.healthMax {

                }
                if checkHealth(player, coop2) > 0 && checkHealth(player, coop2) < player.characters[coop2].race.healthMax {

                }
            } else {
                if currentC!.race.health < currentC!.race.healthMax {

                }
                if checkHealth(player, coop1) > 0 && checkHealth(player, coop1) < player.characters[coop1].race.healthMax {

                }
                if checkHealth(player, coop2) > 0 && checkHealth(player, coop2) < player.characters[coop2].race.healthMax {

                }
            }
        }
    }

    func chooseCurrentCharacter(player: Player, index1: Int, index2: Int) {
        print("\(player.name) choose a character who can play")
        for index in index1...index2 {
            if characterArray[index].race.health > 0 && characterArray[index].canPlay == true {
                print("\(index+1) - \(characterArray[index].name)")
            }
        }
        if let choice = readLine(), !choice.isEmpty {
            switch choice {
                case "1" : currentC = player.characters[0]
                case "2" : currentC = player.characters[1]
                case "3" : currentC = player.characters[2]
                default : chooseCurrentCharacter(player: player, index1: index1, index2: index2)
            }
        } else {
            chooseCurrentCharacter(player: player, index1: index1, index2: index2)
        }
    }
    
    func chooseAttackOrHeal() {
        print("Choose an action to do :")
        print("1 - Attack : - \(currentC!.race.weapon.damage) PV")
        if currentC!.race.weapon.heal > 0 {
            print("2 - Heal :  + \(currentC!.race.weapon.heal) PV")
        }
        if let choice = readLine(), !choice.isEmpty {
            switch choice {
                case "1" : chooseTargetToAttack()
                case "2" : if currentC!.race.weapon.heal > 0 {
                    chooseTargetToHeal()
                } else {
                    chooseAttackOrHeal()
                }
                default:
                    chooseAttackOrHeal()
            }
        }
    }
    
    func chooseTargetToAttack() {
        print("ATTACK")
    }
    
    func chooseTargetToHeal() {
        print("HEAL")
    }

    private func turn() {
        if currentPIndex == currentPArray.count {
            currentPIndex = 0
        }
        // set the current player
        currentP = currentPArray[currentPIndex]
        if currentP.characters[0].canPlay == false && currentP.characters[1].canPlay == false && currentP.characters[2].canPlay == false {
            currentPIndex += 1
            if currentPArray.count == currentPIndex {
                currentPIndex = 0
            }
        }
        if currentPIndex == 1 {
            chooseCurrentCharacter(player: player2, index1: 3, index2: 5)
        } else if currentPIndex == 0 {
            chooseCurrentCharacter(player: player1, index1: 0, index2: 2)
            chooseAttackOrHeal()
        }
        if currentAction != "" && currentTarget != nil {
            doAction()
        }
    }

    // MARK: - PRIVATES FUNCTIONS
    private func characterIsDead(character: Character) {
        if character.race.health == 0 {
            character.canPlay = false
        }
    }

    // function for refresh the health of all characters
    private func refresh(characterArray: [Character]) {
        currentAction = ""
        currentTarget = nil
        currentC = nil
        for index in 0...2 {
            characterIsDead(character: player1.characters[index])
            characterIsDead(character: player2.characters[index])
        }
    }

    private func doAction() {
        guard currentC != nil else { return }
        randomChest.chestAppear(currentC: currentC!)
        if currentAction == "attack" {
            attack()
        }
        if currentAction == "heal" {
            heal()
        }
        characterIsDead(character: currentTarget!)
        isGameOver()
        if game.state == .isOver {
            game.stats()
        } else {
            currentC!.canPlay = false
            currentPIndex += 1
            checkTurn()
            // change the index to go to the next character of the array
            // if the last character played, go back to the first
        if currentPArray.count == currentPIndex {
            currentPIndex = 0
        }
        currentP = currentPArray[currentPIndex]
        refresh(characterArray: characterArray)
        turn()
        }
    }

    // set the game on isOver and a winner
    private func isGameOver() {
        if checkHealth(player1, 0) == 0 && checkHealth(player1, 1) == 0 && checkHealth(player1, 2) == 0 {
            game.winner = player2
            game.state = .isOver
        }
        if checkHealth(player2, 0) == 0 && checkHealth(player2, 1) == 0 && checkHealth(player2, 2) == 0 {
            game.state = .isOver
            game.winner = player1
        }
    }

    private func attack() {
        currentC!.attack(ennemy: currentTarget!)
        // set life on 0 ( cannot be negative )
        if (currentTarget?.race.health)! < 0 {
            currentTarget?.race.health = 0
        }
    }

    private func heal() {
        currentC!.heal(ally: currentTarget!)
        // set life on max even if it heal more
        if (currentTarget?.race.health)! > (currentTarget?.race.healthMax)! {
            currentTarget?.race.health = (currentTarget?.race.healthMax)!
        }
    }

    // increase totalTurn after all alive's character played
    private func checkTurn() {
        var characterPlayed = 0
        for character in characterArray where character.canPlay == false {
            characterPlayed += 1
        }
        if characterPlayed == 6 {
            game.totalTurn += 1
            currentPIndex = 0
            for character in characterArray where character.race.health > 0 {
                character.canPlay = true
            }
        }
    }

    // return health of a character
    private func checkHealth(_ player: Player, _ index: Int) -> Int {
        return player.characters[index].race.health
    }

}

