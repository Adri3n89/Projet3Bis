//
//  Game.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class Game {
    // MARK: - VARIABLES
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
    let currentPArray: [Player]
    var characterArray: [Character]
    var currentPIndex = 0
    var currentC: Character?
    var currentP: Player
    var currentTarget: Character?
    var currentAction: String = ""
    var currentOponent: Player

    // MARK: - INIT
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
        self.currentP = player1
        self.currentOponent = player2
        self.characterArray = player1.characters + player2.characters
        self.currentPArray = [player1, player2]
    }

    // MARK: - FUNCTIONS
    func start() {
        print("Get ready to Fight!")
        print("Turn n°\(totalTurn)")
        turn()
        }

    func stats() {
        if let winner = winner {
            print("\(winner.name) Win the Fight in \(totalTurn) turns !")
            for character in winner.characters {
                if character.race.health == 0 {
                    print("\(character.name) the \(character.race.type) is dead")
                } else {
                    print("\(character.name) the \(character.race.type) have \(character.race.health) PV left.")
                }
            }
        }
    }

    // MARK: - PRIVATES FUNCTIONS
    private func chooseCurrentCharacter() {
        print("\(currentP.name) choose a character who can play")
        for index in 0...2 {
            if checkHealth(currentP, index) > 0 && currentP.characters[index].canPlay == true {
                print("\(index+1) - \(currentP.characters[index].name) : \(checkHealth(currentP, index)) / \(checkHealhMax(currentP, index)) PV")
            }
        }
        if let choice = readLine() {
            switch choice {
            case "1" :
                if currentP.characters[0].canPlay {
                    currentC = currentP.characters[0]
                } else {
                    chooseCurrentCharacter()
                }
            case "2" :
                if currentP.characters[1].canPlay {
                    currentC = currentP.characters[1]
                } else {
                    chooseCurrentCharacter()
                }
            case "3" :
                if currentP.characters[2].canPlay {
                    currentC = currentP.characters[2]
                } else {
                    chooseCurrentCharacter()
                }
            default : chooseCurrentCharacter()
            }
        } else {
            chooseCurrentCharacter()
        }
    }

    private func chooseAttackOrHeal() {
        if let currentC = currentC {
            print("Choose an action to do for \(currentC.name):")
            print("1 - Attack : - \(currentC.race.weapon.damage) PV")
            if currentC.race.weapon.heal > 0 {
                print("2 - Heal :  + \(currentC.race.weapon.heal) PV")
            }
            if let choice = readLine() {
                switch choice {
                case "1" :
                    currentAction = "Attack"
                    chooseTargetToAttack()
                case "2" : if currentC.race.weapon.heal > 0 {
                    currentAction = "Heal"
                    chooseTargetToHeal()
                } else {
                    chooseAttackOrHeal()
                }
                default:
                    chooseAttackOrHeal()
                }
            } else {
                chooseAttackOrHeal()
            }
        }
    }

    private func chooseTargetToAttack() {
        print("Choose a target to attack")
        for index in 0...2 where checkHealth(currentOponent, index) > 0 {
            print("\(index+1) - \(currentOponent.characters[index].name) : \(checkHealth(currentOponent, index)) / \(checkHealhMax(currentOponent, index)) PV")
        }
        if let choice = readLine() {
            switch choice {
            case "1" :
                if checkHealth(currentOponent, 0) > 0 {
                    currentTarget = currentOponent.characters[0]
                } else {
                    chooseTargetToAttack()
                }
            case "2" :
                if checkHealth(currentOponent, 1) > 0 {
                    currentTarget = currentOponent.characters[1]
                } else {
                    chooseTargetToAttack()
                }
            case "3" :
                if checkHealth(currentOponent, 2) > 0 {
                    currentTarget = currentOponent.characters[2]
                } else {
                    chooseTargetToAttack()
                }
            default: chooseTargetToAttack()
            }
        } else {
            chooseTargetToAttack()
        }
    }

    private func chooseTargetToHeal() {
        var targetToHeal = 0
        print("Choose a target to heal")
        for index in 0...2 where checkHealth(currentP, index) > 0 && checkHealth(currentP, index) < checkHealhMax(currentP, index) {
            targetToHeal += 1
            print("\(index+1) - \(currentP.characters[index].name) : \(checkHealth(currentP, index)) / \(checkHealhMax(currentP, index)) PV")
        }
        if targetToHeal == 0 {
            print("no one to heal, go attack")
            chooseAttackOrHeal()
        } else {
            if let choice = readLine() {
                switch choice {
                case "1" :
                    if checkHealth(currentP, 0) > 0 && checkHealth(currentP, 0) < checkHealhMax(currentP, 0) {
                        currentTarget = currentP.characters[0]
                    } else {
                        chooseTargetToHeal()
                    }
                case "2" :
                    if checkHealth(currentP, 1) > 0 && checkHealth(currentP, 1) < checkHealhMax(currentP, 1) {
                        currentTarget = currentP.characters[1]
                    } else {
                        chooseTargetToHeal()
                    }
                case "3" :
                    if checkHealth(currentP, 2) > 0 && checkHealth(currentP, 2) < checkHealhMax(currentP, 2) {
                        currentTarget = currentP.characters[2]
                    } else {
                        chooseTargetToHeal()
                    }
                default: chooseTargetToHeal()
                }
            } else {
                chooseTargetToHeal()
            }
        }
    }

    private func doAction() {
        if let currentC = currentC {
            randomChest.chestAppear(currentC: currentC)
            if currentAction == "Attack" {
                attack()
            }
            if currentAction == "Heal" {
                heal()
            }
            characterIsDead(character: currentTarget!)
            isGameOver()
            if state == .isOver {
                stats()
            } else {
                currentC.canPlay = false
                currentPIndex += 1
                checkTurn()
                if currentPArray.count == currentPIndex {
                    currentPIndex = 0
                }
                currentP = currentPArray[currentPIndex]
                refresh(characterArray: characterArray)
                turn()
            }
        }
    }

    private func turn() {
        if currentPIndex == currentPArray.count {
            currentPIndex = 0
        }
        // set the current player
        currentP = currentPArray[currentPIndex]
        if currentP.name == player1.name {
            currentOponent = player2
        } else {
            currentOponent = player1
        }
        if currentP.characters[0].canPlay == false && currentP.characters[1].canPlay == false && currentP.characters[2].canPlay == false {
            currentPIndex += 1
            if currentPArray.count == currentPIndex {
                currentPIndex = 0
            }
        }
        chooseCurrentCharacter()
        chooseAttackOrHeal()
        doAction()
    }

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

    // set the game on isOver and a winner
    private func isGameOver() {
        if checkHealth(player1, 0) == 0 && checkHealth(player1, 1) == 0 && checkHealth(player1, 2) == 0 {
            winner = player2
            state = .isOver
        }
        if checkHealth(player2, 0) == 0 && checkHealth(player2, 1) == 0 && checkHealth(player2, 2) == 0 {
            state = .isOver
            winner = player1
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
            totalTurn += 1
            print("Turn n°\(totalTurn)")
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

    private func checkHealhMax(_ player: Player, _ index: Int) -> Int {
        return player.characters[index].race.healthMax
    }
}
