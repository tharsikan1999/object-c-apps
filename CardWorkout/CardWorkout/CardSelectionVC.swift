//
//  CardSelectionVC.swift
//  CardWorkout
//
//  Created by Tharsikan Sathasivam on 2025-11-14.
//

import UIKit

class CardSelectionVC: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    
    
    var timer: Timer?
    
    var cards: [UIImage] = Card.allValues
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        for button in buttons {
            button.layer.cornerRadius = 12
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    func randomCard() -> UIImage {
        let randomIndex = Int.random(in: 0..<cards.count)
        return cards[randomIndex]
    }
    
    func  startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.imageView.image = self.randomCard()
        })
    }
    
    
    @IBAction func stopButton(_ sender: Any) {
        timer?.invalidate()
    }
    

    @IBAction func restartButton(_ sender: Any) {
        timer?.invalidate()
        startTimer()
    }
    

}
