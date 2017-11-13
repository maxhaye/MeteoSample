//
//  ViewController.swift
//  Meteo
//
//  Created by Maxime Haye on 13/11/2017.
//  Copyright © 2017 Maxime Haye. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var townTableView: UITableView!
    var townList = [("Paris"),("Tokyo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        townTableView.delegate = self
        townTableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell", for: indexPath)
        
        cell.textLabel?.text = townList[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return townList.count
    }

}

