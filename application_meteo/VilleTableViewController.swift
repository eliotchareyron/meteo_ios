//
//  VilleTableViewController.swift
//  application_meteo
//
//  Created by etudiant on 11/04/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit
import SDWebImage

class VilleTableViewController: UITableViewController {
    
 var ville = [Ville]()
    
 let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        dicover(name: "Grenoble")
   
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ville.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "VilleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? VilleTableViewCell else {
                fatalError("no cell")
        }
        
        let city = ville[indexPath.row]
               
        cell.name.text = city.name
        cell.temperature.text = "\(city.temperature)"
        
        print(city.icon)
        cell.imageview.sd_setImage(with: URL(string: city.icon), placeholderImage: UIImage(named: "default.png"))
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass the selected object to the new view controller.
        switch(segue.identifier ?? "") {
        case "ShowDetail":
            guard let serieDetailViewController = segue.destination as? VilleViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? VilleTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            
           
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let ville_liste: Ville
            ville_liste = ville[indexPath.row]
            serieDetailViewController.city = ville_liste
            
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }

     }
 
    
    // MARK: - Private function
    public func dicover(name : String) {
        
        let api = "http://api.openweathermap.org/data/2.5/weather?q=" + name + "&units=metric&appid=b81e02e381c744a3038085cd01c3aa3c"
        
    
        let url = URL(string: api)
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                   
                
                    var id: NSNumber = 0
                    var name: String = ""
                    var temperature: NSNumber =  0
                    var pression: NSNumber = 0
                    var humidite: NSNumber = 0
                    var tempmax : NSNumber = 0
                    var tempmin : NSNumber = 0
                    var icon : String = ""
                    let address_icon : String = "http://openweathermap.org/img/w/"
                    let icon_type : String = ".png"
                    
                    
                    id = parsedData["id"] as! NSNumber
                    name = parsedData["name"] as! String
                    
                
                    let results = parsedData["main"] as! [String:Any]

                    temperature = results["temp"] as! NSNumber
                    pression =  results["pressure"]  as! NSNumber
                    humidite  =  results["humidity"]  as! NSNumber
                    tempmax =  results["temp_max"]  as! NSNumber
                    tempmin =  results["temp_min"]  as! NSNumber

                    let weather = parsedData["weather"] as! NSArray
                    let weather2 = weather[0] as! [String:Any]
                    let img : String! = weather2["icon"] as! String!
                    
                    icon = address_icon + img + icon_type

                    let ville1 = Ville(id: id,name: name,temperature: temperature,pression: humidite,humidite: pression,tempmax: tempmax,tempmin: tempmin,icon: icon)
                    
                        self.ville = [ville1]
                        //self.ville.append(ville1)
                                               
                    
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    //print(name)
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
        
    }

}


extension VilleTableViewController : UISearchBarDelegate {
    @available(iOS 8.0, *)
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dicover(name: searchController.searchBar.text!)
        
    }
}



