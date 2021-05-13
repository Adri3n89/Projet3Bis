//
//  RandomChest.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class RandomChest {
    
    func chestAppear(currentC: Character) {
        let randomNumber2: Int = .random(in: 0...3)
        let randomNumber: Int = .random(in: 0...2)
        if randomNumber2 == 2 {
        switch currentC!.race.type {
        case .elf : randomWeapon = arrayBow[randomNumber]
        case .dwarf : randomWeapon = arrayAxe[randomNumber]
        case .human : randomWeapon = arraySword[randomNumber]
        case .wizzard : randomWeapon = arrayStick[randomNumber]
        }
        currentC!.race.weapon = randomWeapon!
            delegate.alert()
        }
    }
}
