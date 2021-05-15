//
//  RandomChest.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class RandomChest {
    
    let arrayBow = [BaseBow(), HealBow(), StrongBow()]
    let arraySword = [BaseSword(), HealSword(), StrongSword()]
    let arrayStick = [BaseStick(), HealStick(), StrongStick()]
    let arrayAxe = [BaseAxe(), HealAxe(), StrongAxe()]
    
    func chestAppear(currentC: Character) {
        let randomNumber2: Int = .random(in: 0...3)
        let randomNumber: Int = .random(in: 0...2)
        let randomWeapon: Weapon!
        if randomNumber2 == 2 {
        switch currentC.race.type {
        case .elf : randomWeapon = arrayBow[randomNumber]
        case .dwarf : randomWeapon = arrayAxe[randomNumber]
        case .human : randomWeapon = arraySword[randomNumber]
        case .wizzard : randomWeapon = arrayStick[randomNumber]
        }
        currentC.race.weapon = randomWeapon
            print("A treasure Chest appear with a \(randomWeapon.name) in it\nWith \(randomWeapon.damage) damage and \(randomWeapon.heal) heal")
        }
    }
}
