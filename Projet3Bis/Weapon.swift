//
//  Weapon.swift
//  Projet3Bis
//
//  Created by Adrien PEREA on 13/05/2021.
//

import Foundation

class Weapon {
    // MARK: - VARIABLES
    var name: String
    var damage: Int
    var heal: Int

    // MARK: - INIT
    init(name: String, damage: Int, heal: Int) {
        self.name = name
        self.damage = damage
        self.heal = heal
    }
}

class BaseBow: Weapon {
    init() {
        super.init(name: "bow", damage: 50, heal: 0)
    }
}

class StrongBow: Weapon {
    init() {
        super.init(name: "bow", damage: 75, heal: 0)
    }
}

class HealBow: Weapon {
    init() {
        super.init(name: "bow", damage: 20, heal: 35)
    }
}

class BaseAxe: Weapon {
    init() {
        super.init(name: "axe", damage: 60, heal: 0)
    }
}

class StrongAxe: Weapon {
    init() {
        super.init(name: "axe", damage: 85, heal: 0)
    }
}

class HealAxe: Weapon {
    init() {
        super.init(name: "axe", damage: 30, heal: 35)
    }
}

class BaseSword: Weapon {
    init() {
        super.init(name: "sword", damage: 70, heal: 0)
    }
}

class StrongSword: Weapon {
    init() {
        super.init(name: "sword", damage: 95, heal: 0)
    }
}

class HealSword: Weapon {
    init() {
        super.init(name: "sword", damage: 40, heal: 35)
    }
}

class BaseStick: Weapon {
    init() {
        super.init(name: "stick", damage: 25, heal: 35)
    }
}

class StrongStick: Weapon {
    init() {
        super.init(name: "stick", damage: 60, heal: 20)
    }
}

class HealStick: Weapon {
    init() {
        super.init(name: "stick", damage: 20, heal: 55)
    }
}
