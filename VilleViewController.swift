//
//  VilleViewController.swift
//  application_meteo
//
//  Created by etudiant on 11/04/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit

class VilleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidite: UILabel!
    @IBOutlet weak var pression: UILabel!
    @IBOutlet weak var tempmax: UILabel!
    @IBOutlet weak var tempmin: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var meteo = [Meteo]()
    var city: Ville?
    var id : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let ville = city {
            name.text = ville.name
            temperature.text = "\(ville.temperature)"
            humidite.text = "\(ville.humidite)"
            pression.text = "\(ville.pression)"
            tempmax.text = "\(ville.tempmax)"
            tempmin.text = "\(ville.tempmin)"
            id = "\(ville.id)"
        }
        
        data(id: id)
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return meteo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cellIdentifier = "meteocellidentifier"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? meteoTableViewCell else {
                fatalError("no cell")
        }
        
        let weather = meteo[indexPath.row]
        
        cell.day.text = weather.day
        cell.temp.text = "\(weather.temp)"
        
        return cell
    }
    
    
    func data( id : String) {
        let api : String = "http://api.openweathermap.org/data/2.5/forecast?id=" + id + "&units=metric&appid=b81e02e381c744a3038085cd01c3aa3c"
        
        let url = URL(string: api)
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let results: NSArray = (parsedData["list"] as? NSArray)!
                    
                    var day: String
                    var temp : NSNumber
                    print(results)
                   
                    // Cast "dict" en NSDICTIONNARY
                    for dict in results as! [NSDictionary]{
                        
                        day = dict.value(forKey: "dt_txt") as! String
                     
                        let results = dict.value(forKey:"main") as! [String:Any]
                        
                        temp = results["temp"] as! NSNumber
                       
                        let meteo1 = Meteo(day: day, temp: temp)
                        self.meteo += [meteo1]
                        DispatchQueue.main.async {
                            self.tableView.reloadData()

                            
                        }
                        
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
        
    }

}

