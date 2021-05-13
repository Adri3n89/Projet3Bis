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
    
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    // set the game on isOver and a winner
    private func isGameOver() {
        if player1.characters[0].race.health == 0 && player1.characters[1].race.health == 0 && player1.characters[2].race.health == 0 {
            winner = player2
            state = .isOver
        }
        if player2.characters[0].race.health == 0 && player2.characters[1].race.health == 0 && player2.characters[2].race.health == 0 {
            state = .isOver
            winner = player1
        }
    }
}
