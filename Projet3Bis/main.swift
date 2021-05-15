//
//  main.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

let setup = Setup()
setup.setupGame()
let game = Game(player1: setup.player1, player2: setup.player2)
game.start()
print("restart?")
