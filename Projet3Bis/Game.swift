//
//  Game.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
// swiftlint:disable all

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
    let player1 = Player()
    let player2 = Player()
    let randomChest = RandomChest()
    var currentPArray: [Player] = []
    var characterArray: [Character] = []
    var currentPIndex = 0
    var currentC: Character?
    var currentP: Player
    var currentTarget: Character?
    var currentAction: String = ""
    var currentOpponent: Player
    var isPlayer2: Bool = false
    
    init() {
        currentP = player1
        currentOpponent = player2
    }

    // MARK: - FUNCTIONS
    
    func setupGame() {
        createPlayer(player: player1)
        while player1.characters.count <= 2 {
            createCharacter(player: player1)
        }
        isPlayer2 = true
        createPlayer(player: player2)
        while player2.characters.count <= 2 {
            createCharacter(player: player2)
        }
    }
    
    func start() {
        print("Get ready to Fight!")
        print("Turn n°\(totalTurn)")
        characterArray = player1.characters + player2.characters
        currentPArray = [player1, player2]
        turn()
        }
    
    
    // MARK: - PRIVATES FUNCTIONS

    private func stats() {
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
    
    private func restart() {
        print("restart?\n1 - YES\n2 - NO")
        if let choice = readLine() {
            switch choice {
            case "1" :
                isPlayer2 = false
                player1.name = ""
                player2.name = ""
                player1.characters.removeAll()
                player2.characters.removeAll()
                state = .isOngoing
                totalTurn = 1
                currentPIndex = 0
                setupGame()
                characterArray = player1.characters + player2.characters
                start()
            case "2" :
                print("Have a nice day !")
            default : restart()
            }
        } else {
            restart()
        }
    }
    
    private func createPlayer(player: Player) {
        if isPlayer2 {
            print("Hello, choose a name for your player 2")
        } else {
            print("Hello, choose a name for your player 1")
        }
        if let name = readLine(), !name.isEmpty {
            if name.count < 3 {
                print("your Player must have 3 letters in his name")
                createPlayer(player: player)
            } else {
                player.name = name
                if isPlayer2 {
                    if player2.name.capitalized == player1.name.capitalized {
                        print("You can't choose the same name that Player 1")
                        createPlayer(player: player)
                    }
                }
            }
        } else {
            print("your Player must have 3 letters in his name")
            createPlayer(player: player)
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
               if name.count < 3 {
                   print("your Character must have 3 letters in his name")
                   chooseName(player: player)
               } else {
                   validateCharacterName(name: name, player: player)
               }
           } else {
               print("Your Character must have a name, please choose one")
               chooseName(player: player)
           }
       }

    private func validateCharacterName(name: String, player: Player) {
        let names = player1.characters.map { character in
            return character.name.capitalized
        } + player2.characters.map { character in
            return character.name.capitalized
        }
        if names.contains(name.capitalized) {
            print("Your Character can't have the same name of another Character")
            chooseName(player: player)
        } else {
            chooseRace(name: name, player: player)
        }
    }

    private func chooseRace(name: String, player: Player) {
        let race: Race
        print("Choose a Race for your Character")
        print("""
            1 - Elf
            2 - Human
            3 - Wizzard
            4 - Dwarf
            """)
        if let raceChoice = readLine(), !raceChoice.isEmpty {
            switch raceChoice {
            case "1" :
                race = Elf()
                player.characters.append(Character(name: name, race: race))
            case "2" :
                race = Human()
                player.characters.append(Character(name: name, race: race))
            case "3" :
                race = Wizzard()
                player.characters.append(Character(name: name, race: race))
            case "4" :
                    race = Dwarf()
                    player.characters.append(Character(name: name, race: race))
            default : chooseRace(name: name, player: player)
            }
        } else {
            chooseRace(name: name, player: player)
        }
    }

    private func chooseCurrentCharacter() {
        print("\(currentP.name) choose a character who can play")
        for index in 0...2 {
            if showHealth(currentP, index) > 0 && currentP.characters[index].canPlay == true {
                print("\(index+1) - \(currentP.characters[index].name) : \(showHealth(currentP, index)) / \(showHealthMax(currentP, index)) PV")
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
        for index in 0...2 where showHealth(currentOpponent, index) > 0 {
            print("\(index+1) - \(currentOpponent.characters[index].name) : \(showHealth(currentOpponent, index)) / \(showHealthMax(currentOpponent, index)) PV")
        }
        if let choice = readLine() { // TODO Optimiser comme le heal
            switch choice {
            case "1" :
                if showHealth(currentOpponent, 0) > 0 {
                    currentTarget = currentOpponent.characters[0]
                } else {
                    chooseTargetToAttack()
                }
            case "2" :
                if showHealth(currentOpponent, 1) > 0 {
                    currentTarget = currentOpponent.characters[1]
                } else {
                    chooseTargetToAttack()
                }
            case "3" :
                if showHealth(currentOpponent, 2) > 0 {
                    currentTarget = currentOpponent.characters[2]
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
        for index in 0...2 where showHealth(currentP, index) > 0 && showHealth(currentP, index) < showHealthMax(currentP, index) {
            targetToHeal += 1
            print("\(index+1) - \(currentP.characters[index].name) : \(showHealth(currentP, index)) / \(showHealthMax(currentP, index)) PV")
        }
        if targetToHeal == 0 {
            print("no one to heal, go attack")
            chooseAttackOrHeal()
        } else {
            if let choice = readLine() {
                if let value = Int(choice), (value > 0 && value < 4) {
                    heal(choice: value-1)
                } else {
                    chooseTargetToHeal()
                }
            }
        }
    }

    private func heal(choice: Int) {
        if showHealth(currentP, choice) > 0 && showHealth(currentP, choice) < showHealthMax(currentP, choice) {
            currentTarget = currentP.characters[choice]
        } else {
            chooseTargetToHeal()
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
            if let currentTarget = currentTarget {
                characterIsDead(character: currentTarget)
            }
            isGameOver()
            if state == .isOver {
                stats()
                restart()
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
            currentOpponent = player2
        } else {
            currentOpponent = player1
        }
        if currentP.characters[0].canPlay == false && currentP.characters[1].canPlay == false && currentP.characters[2].canPlay == false {
            currentPIndex += 1
            if currentPArray.count == currentPIndex {
                currentPIndex = 0
            }
            turn()
        } else {
            chooseCurrentCharacter()
            chooseAttackOrHeal()
            doAction()
        }
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
        if showHealth(player1, 0) == 0 && showHealth(player1, 1) == 0 && showHealth(player1, 2) == 0 {
            winner = player2
            state = .isOver
        }
        if showHealth(player2, 0) == 0 && showHealth(player2, 1) == 0 && showHealth(player2, 2) == 0 {
            state = .isOver
            winner = player1
        }
    }

    private func attack() {
        if let currentC = currentC, let currentTarget = currentTarget {
            currentC.attack(ennemy: currentTarget)
            // set life on 0 ( cannot be negative )
            if (currentTarget.race.health) < 0 {
                currentTarget.race.health = 0
            }
        }
    }

    private func heal() {
        if let currentC = currentC, let currentTarget = currentTarget {
            currentC.heal(ally: currentTarget)
            // set life on max even if it heal more
            if (currentTarget.race.health) > (currentTarget.race.healthMax) {
                currentTarget.race.health = (currentTarget.race.healthMax)
            }
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
    private func showHealth(_ player: Player, _ index: Int) -> Int {
        return player.characters[index].race.health
    }

    private func showHealthMax(_ player: Player, _ index: Int) -> Int {
        return player.characters[index].race.healthMax
    }
}
