//
//  ColorTableVC.swift
//  RandomColor
//
//  Created by Tharsikan Sathasivam on 2025-11-14.
//

import UIKit

class ColorTableVC: UIViewController {
    
    var colors: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRandomColors()
    }
    
    func createRandomColors() {
        for _ in 0..<50 {
            colors.append(createRandomColor())
        }
    }
    
    func createRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toColorDetailVC" {
            if let destinationVC = segue.destination as? ColorDetailVC,
               let selectedColor = sender as? UIColor {
                destinationVC.color = selectedColor
            }
        }
    } // <-- Missing brace added here
}

extension ColorTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell") else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        performSegue(withIdentifier: "toColorDetailVC", sender: color)
    }
}
