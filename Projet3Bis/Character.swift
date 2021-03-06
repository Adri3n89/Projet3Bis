//
//  Character.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class Character: Equatable {
    // MARK: - VARIABLES
    var name: String
    var race: Race
    var canPlay = true

    // MARK: - INIT
    init(name: String, race: Race) {
        self.name = name
        self.race = race
    }

    // MARK: - FUNCTIONS
    func attack(ennemy: Character) {
        ennemy.race.health -= race.weapon.damage
    }

    func heal(ally: Character) {
        ally.race.health += race.weapon.heal
    }

    // MARK: - EQUATABLE PROTOCOL FUNCTION
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.name == rhs.name
    }
}
