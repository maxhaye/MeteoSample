//
//  DetailViewController.swift
//  Meteo
//
//  Created by Maxime Haye on 13/11/2017.
//  Copyright © 2017 Maxime Haye. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var detailTown : Town?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let town = detailTown {
            self.nameLabel.text = "Ville de \(town.name)"
            self.temperatureLabel.text = "Température moyenne : \(town.temperature)"
            self.descriptionLabel.text = "Description : \(town.localInformation)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
