//
//  Game.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
// swiftlint:disable all

import Foundation

class Game {
    // MARK: - VARIABLES
    var gameOn = true
    var totalTurn: Int = 1
    var winner: Player?
    let player1 = Player()
    let player2 = Player()
    var characterArray: [Character] = []
    var currentC: Character?
    var currentPlayer: Player
    var currentTarget: Character?
    var currentAction: String = ""
    var currentOpponent: Player
    var isPlayer2: Bool = false

    // MARK: - INIT
    init() {
        currentPlayer = player1
        currentOpponent = player2
    }

    // MARK: - FUNCTIONS
    // set the players names and create all characters for the game
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

    // launch the game
    func start() {
        print("Get ready to Fight!")
        print("Turn n°\(totalTurn)")
        characterArray = player1.characters + player2.characters
        turn()
        }

    // MARK: - PRIVATES FUNCTIONS

    // set the name a your player
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

    // launch the creation of a character for a player
    private func createCharacter(player: Player) {
        if player.characters.count == 0 {
            print("Choose a name for your first Character")
        } else if player.characters.count == 1 {
            print("Choose a name for your second Character")
        } else {
            print("Choose a name for your third Character")
        }
        if let name = readLine(), !name.isEmpty {
            if name.count < 3 {
                print("your Character must have 3 letters in his name")
                createCharacter(player: player)
            } else {
                validateCharacterName(name: name, player: player)
            }
        } else {
            print("Your Character must have a name, please choose one")
            createCharacter(player: player)
        }
    }

    // check names of all character by making an Array
    private func validateCharacterName(name: String, player: Player) {
        let names = player1.characters.map { character in
            return character.name.capitalized
        } + player2.characters.map { character in
            return character.name.capitalized
        }
        // check if the name enter is in the array
        if names.contains(name.capitalized) {
            print("Your Character can't have the same name of another Character")
            createCharacter(player: player)
        } else {
            chooseRace(name: name, player: player)
        }
    }

    // chose a race for the character
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

    // a player turn, choose a character, an action, and do the action
    private func turn() {
        currentOpponent = (currentPlayer.name == player1.name ? player2 : player1)
        if !currentPlayer.characters[0].canPlay && !currentPlayer.characters[1].canPlay && !currentPlayer.characters[2].canPlay {
            currentPlayer = (currentPlayer.name == player1.name ? player2 : player1)
            turn()
        } else {
            chooseCurrentCharacter()
            chooseAttackOrHeal()
            doAction()
        }
    }

    // choose a current Character in your team and check your choice if the selected character can play
    private func chooseCurrentCharacter() {
        print("\(currentPlayer.name) choose a character who can play")
        for index in 0...2 {
            if showHealth(currentPlayer, index) > 0 && currentPlayer.characters[index].canPlay == true {
                print("\(index+1) - \(currentPlayer.characters[index].name) : \(showHealth(currentPlayer, index)) / \(showHealthMax(currentPlayer, index)) PV")
            }
        }
        if let choice = readLine() {
            if let value = Int(choice), (value > 0 && value < 4) {
                canPlayCheck(choice: value-1)
            } else {
                chooseCurrentCharacter()
            }
        }
    }

    // check if the current Player can play
    private func canPlayCheck(choice: Int) {
        if currentPlayer.characters[choice].canPlay {
            currentC = currentPlayer.characters[choice]
        } else {
            chooseCurrentCharacter()
        }
    }

    // chose the current action to do for your current Character
    private func chooseAttackOrHeal() {
        if let currentC = currentC {
            print("Choose an action to do for \(currentC.name):")
            print("1 - Attack : - \(currentC.race.weapon.damage) PV")
            if currentC.race.weapon.heal > 0 {
                print("2 - Heal :  + \(currentC.race.weapon.heal) PV")
            }
            if let choice = readLine() {
                if choice == "1" {
                    currentAction = "Attack"
                    chooseTargetToAttack()
                } else if choice == "2" && currentC.race.weapon.heal > 0 {
                        currentAction = "Heal"
                        chooseTargetToHeal()
                } else {
                    chooseAttackOrHeal()
                }
            }
        }
    }

    // print every target you can attack and choose one
    private func chooseTargetToAttack() {
        print("Choose a target to attack")
        for index in 0...2 where showHealth(currentOpponent, index) > 0 {
            print("\(index+1) - \(currentOpponent.characters[index].name) : \(showHealth(currentOpponent, index)) / \(showHealthMax(currentOpponent, index)) PV")
        }
        if let choice = readLine() {
            if let value = Int(choice), (value > 0 && value < 4) {
                attackCheck(choice: value-1)
            } else {
                chooseTargetToAttack()
            }
        }
    }

    // check if the target is not dead
    private func attackCheck(choice: Int) {
        if showHealth(currentOpponent, choice) > 0 {
            currentTarget = currentOpponent.characters[choice]
        } else {
            chooseTargetToAttack()
        }
    }

    // print every teammate and himself who can be heal to select one
    private func chooseTargetToHeal() {
        var targetToHeal = 0
        print("Choose a target to heal")
        // check if there is target to heal
        for index in 0...2 where showHealth(currentPlayer, index) > 0 && showHealth(currentPlayer, index) < showHealthMax(currentPlayer, index) {
            targetToHeal += 1
            print("\(index+1) - \(currentPlayer.characters[index].name) : \(showHealth(currentPlayer, index)) / \(showHealthMax(currentPlayer, index)) PV")
        }
        // if no one can be heal go choose attack
        if targetToHeal == 0 {
            print("no one to heal, go attack")
            chooseAttackOrHeal()
        } else {
            // else check if the choice can be heal
            if let choice = readLine() {
                if let value = Int(choice), (value > 0 && value < 4) {
                    healCheck(choice: value-1)
                } else {
                    chooseTargetToHeal()
                }
            }
        }
    }

    // check if the character target is not dead or health full
    private func healCheck(choice: Int) {
        if showHealth(currentPlayer, choice) > 0 && showHealth(currentPlayer, choice) < showHealthMax(currentPlayer, choice) {
            currentTarget = currentPlayer.characters[choice]
        } else {
            chooseTargetToHeal()
        }
    }

    // the character perform the action choosed
    private func doAction() {
        if let currentC = currentC {
            let randomChest = RandomChest()
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
            if gameOn == false {
                stats()
                restart()
            } else {
                currentC.canPlay = false
                currentPlayer = (currentPlayer.name == player1.name ? player2 : player1)
                checkTurn()
                turn()
            }
        }
    }

    // check health to put a death character canPlay to false
    private func characterIsDead(character: Character) {
        if character.race.health == 0 {
            character.canPlay = false
        }
    }

    // set the gameOn on False and a winner
    private func isGameOver() {
        if showHealth(player1, 0) == 0 && showHealth(player1, 1) == 0 && showHealth(player1, 2) == 0 {
            winner = player2
            gameOn = false
        }
        if showHealth(player2, 0) == 0 && showHealth(player2, 1) == 0 && showHealth(player2, 2) == 0 {
            winner = player1
            gameOn = false
        }
    }

    // perform attack of the current character
    private func attack() {
        if let currentC = currentC, let currentTarget = currentTarget {
            currentC.attack(ennemy: currentTarget)
            // set life on 0 ( cannot be negative )
            if (currentTarget.race.health) < 0 {
                currentTarget.race.health = 0
            }
        }
    }

    // perform heal of the current character
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
            currentPlayer = player1
            for character in characterArray where character.race.health > 0 {
                character.canPlay = true
            }
        }
    }

    // return health of a character
    private func showHealth(_ player: Player, _ index: Int) -> Int {
        return player.characters[index].race.health
    }

    // return MaxHealth of a character
    private func showHealthMax(_ player: Player, _ index: Int) -> Int {
        return player.characters[index].race.healthMax
    }

    // show the details of the game
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

    // ask the user if he want to launch another game of not
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
                gameOn = true
                totalTurn = 1
                setupGame()
                start()
            case "2" :
                print("Have a nice day !")
            default : restart()
            }
        } else {
            restart()
        }
    }

}


