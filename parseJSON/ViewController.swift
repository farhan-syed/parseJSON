//
//  ViewController.swift
//  parseJSON
//
//  Created by Farhan Syed on 4/9/17.
//  Copyright © 2017 Farhan Syed. All rights reserved.
//

import UIKit

class ViewController: UITableViewController  {
    
    var tableArray = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        parseJSON()
        
    }
    
    func parseJSON() {
        
        let url = URL(string: "https://api.myjson.com/bins/vi56v")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
        guard error == nil else {
            print("returning error")
            return
        }
        
        guard let content = data else {
            print("not returning data")
            return
        }
        
        guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
            print("Error")
            return
        }
        
        if let array = json["companies"] as? [String] {
            self.tableArray = array
        }
        
        print(self.tableArray)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
            
        }
        
        task.resume()
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        
        cell.textLabel?.text = self.tableArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tableArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.tableArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}


