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

class Human: Race {
    init() {
        super.init(weapon: BaseSword(), health: 200, healthMax: 200, type: .human)
    }
}

class Wizzard: Race {
    init() {
        super.init(weapon: BaseStick(), health: 250, healthMax: 250, type: .wizzard)
    }
}

class Dwarf: Race {
    init() {
        super.init(weapon: BaseAxe(), health: 275, healthMax: 275, type: .dwarf)
    }
}

class Elf: Race {
    init() {
        super.init(weapon: BaseBow(), health: 300, healthMax: 300, type: .elf)
    }
}
