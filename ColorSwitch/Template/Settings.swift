//
//  Settings.swift
//  Settings
//
//  Created by Nilesh Kumar on 19/12/21.
//

import SpriteKit

enum physicsCategories {
    
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1 //01
    static let switchCategory: UInt32 = 0x1 << 1 // 10
    
}

enum zPositions{
    
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}
