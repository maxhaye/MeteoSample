//
//  ViewController.swift
//  Meteo
//
//  Created by Maxime Haye on 13/11/2017.
//  Copyright © 2017 Maxime Haye. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var townTableView: UITableView!
    var towns : [Town] = [Town]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        townTableView.delegate = self
        townTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath)
        let town = towns[indexPath.row]
        cell.textLabel?.text = (" \(town.name) : \(town.temperature)°C , \(town.localInformation)")
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return towns.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let town = towns[indexPath.row]
        
        self.performSegue(withIdentifier: "SegueToDetail", sender: town)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let town: Town = sender as! Town
        if segue.identifier == "SegueToDetail" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.detailTown = town
            }
        }
    }
    
    @IBAction func addNewTown(_ sender: Any) {
        let alertController = UIAlertController(title: "Ajouter une nouvelle ville", message: nil, preferredStyle: .alert)
    
        let confirmAction = UIAlertAction(title: "Enregistrer", style: .default) { (_) in
            
            let town = alertController.textFields?[0].text
            if let townName = town {
                self.requestMeteoInformation(townName: townName)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Nom de ville"
        }
       
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setup() {
        self.townTableView.reloadData()
    }
    
    func requestMeteoInformation(townName: String)  {
        let url = "http://api.openweathermap.org/data/2.5/weather?q=\(townName)&APPID=011728ceb26f2404312ed3a3e95effdb&units=metric&lang=fr"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["cod"] == 200 {
                    let town = Town(json: json)
                    self.towns.append(town)
                    self.setup()
                }
                else {
                    print("Une erreur c'est produite")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

