//
//  Card.swift
//  CardWorkout
//
//  Created by Tharsikan Sathasivam on 2025-11-15.
//

import UIKit

struct Card {
    static let allValues: [UIImage] = {
        let ranks = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
        let suits = ["H","S","C","D"]
        
        return suits.flatMap { suit in
            ranks.compactMap { rank in
                UIImage(named: "\(rank)\(suit)")
            }
        }
    }()
}
