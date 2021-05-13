//
//  Race.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class Race {
    var weapon: Weapon
    var health: Int
    let healthMax: Int
    var type: Type

    init(weapon: Weapon, health: Int, healthMax: Int, type: Type) {
        self.weapon = weapon
        self.health = health
        self.healthMax = healthMax
        self.type = type
    }
}

enum `Type`: String {
    case elf
    case human
    case wizzard
    case dwarf
}
