//
//  RandomChest.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class RandomChest {
    // MARK: - VARIABLES
    let arrayBow = [BaseBow(), HealBow(), StrongBow()]
    let arraySword = [BaseSword(), HealSword(), StrongSword()]
    let arrayStick = [BaseStick(), HealStick(), StrongStick()]
    let arrayAxe = [BaseAxe(), HealAxe(), StrongAxe()]

    // MARK: - FUNCTIONS
    func chestAppear(currentC: Character) {
        let randomNumber2: Int = .random(in: 0...3)
        let randomNumber: Int = .random(in: 0...2)
        let randomWeapon: Weapon?
        if randomNumber2 == 2 {
            switch currentC.race.type {
            case .elf : randomWeapon = arrayBow[randomNumber]
            case .dwarf : randomWeapon = arrayAxe[randomNumber]
            case .human : randomWeapon = arraySword[randomNumber]
            case .wizzard : randomWeapon = arrayStick[randomNumber]
            }
            if let newWeapon = randomWeapon {
                currentC.race.weapon = newWeapon
                print("A treasure Chest appear with a \(newWeapon.name) in it")
                print("with \(newWeapon.damage) damage and \(newWeapon.heal) heal")
            }
        }
    }

}
