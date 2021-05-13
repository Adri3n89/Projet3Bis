//
//  Weapon.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class Weapon {
    var name: String
    var damage: Int
    var heal: Int

    init(name: String, damage: Int, heal: Int) {
        self.name = name
        self.damage = damage
        self.heal = heal
    }
}
