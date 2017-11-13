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
        townTableView.allowsMultipleSelectionDuringEditing = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        towns = [Town]()
        let townList : [String] = UserDefaults.standard.object(forKey: "townList") as! [String]
        for townName in townList {
            self.requestMeteoInformation(townName: townName)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let town: Town = sender as! Town
        if segue.identifier == "SegueToDetail" {
            if let toViewController = segue.destination as? DetailViewController {
                toViewController.detailTown = town
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath)
        let town = towns[indexPath.row]
        cell.textLabel?.text = (" \(town.name) : \(town.temperature)°C , \(town.localInformation)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.towns.remove(at: indexPath.row)
            self.setup()
        }
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
        var townList = [String]()
        for town in towns {
            townList.append(town.name)
        }
        UserDefaults.standard.set(townList, forKey: "townList")
        
    }
    
    static let apiUrl : String = "http://api.openweathermap.org/data/2.5/"
    static let APPID : String = "011728ceb26f2404312ed3a3e95effdb"
    static let units : String = "metric"
    static let lang : String = "fr"
    
    func requestMeteoInformation(townName: String)  {
        let url = "\(ViewController.apiUrl)weather?q=\(townName)&APPID=\(ViewController.APPID)&units=\(ViewController.units)&lang=\(ViewController.lang)"
        
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
                    self.showError()
                }
            case .failure(let error):
                print(error)
                self.showError()
            }
        }
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Attention", message: "Une erreur c'est produite", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}



