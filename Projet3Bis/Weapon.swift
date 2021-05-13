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

class BaseBow: Weapon {
    init() {
        super.init(name: "bow", damage: 40, heal: 0)
    }
}

class StrongBow: Weapon {
    init() {
        super.init(name: "bow", damage: 65, heal: 0)
    }
}

class HealBow: Weapon {
    init() {
        super.init(name: "bow", damage: 30, heal: 25)
    }
}

class BaseAxe: Weapon {
    init() {
        super.init(name: "axe", damage: 50, heal: 0)
    }
}

class StrongAxe: Weapon {
    init() {
        super.init(name: "axe", damage: 75, heal: 0)
    }
}

class HealAxe: Weapon {
    init() {
        super.init(name: "axe", damage: 30, heal: 25)
    }
}

class BaseSword: Weapon {
    init() {
        super.init(name: "sword", damage: 60, heal: 0)
    }
}

class StrongSword: Weapon {
    init() {
        super.init(name: "sword", damage: 85, heal: 0)
    }
}

class HealSword: Weapon {
    init() {
        super.init(name: "sword", damage: 40, heal: 25)
    }
}

class BaseStick: Weapon {
    init() {
        super.init(name: "stick", damage: 25, heal: 35)
    }
}

class StrongStick: Weapon {
    init() {
        super.init(name: "stick", damage: 50, heal: 20)
    }
}

class HealStick: Weapon {
    init() {
        super.init(name: "stick", damage: 20, heal: 45)
    }
}

