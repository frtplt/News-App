//
//  NewsAppViewController.swift
//  News App
//
//  Created by Firat on 3.01.2022.
//

import UIKit

class NewsAppViewController: UIViewController {
    
    var selectedButton = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func englishButtonPressed(_ sender: UIButton) {
        selectedButton = 1
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    @IBAction func turkishButtonPressed(_ sender: UIButton) {
        selectedButton = 2
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if selectedButton == 1 {
            let destinationVC = segue.destination as! ViewController
            
            destinationVC.url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=998cf5debc8c4fe4b2845144197a30ad"
            
        }else if selectedButton == 2 {
            let destinationVC = segue.destination as! ViewController
            
            destinationVC.url = "https://newsapi.org/v2/top-headlines?country=tr&apiKey=998cf5debc8c4fe4b2845144197a30ad"
            
        }
    }
    
}
