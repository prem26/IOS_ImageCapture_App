//
//  TableViewController.swift
//  ImageCaptureApp
//
//  Created by Herath Mudiyanselage Nethanjan Danindu Premaratne on 3/11/17.
//  Copyright © 2017 Herath Mudiyanselage Nethanjan Danindu Premaratne. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    // Outlet for Search Field
    @IBOutlet weak var searchText: UISearchBar!
    
    //Outlet for Table View
    @IBOutlet weak var tableview: UITableView!
    
    var data = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let del = UIApplication.shared.delegate as! AppDelegate
        let context = del.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Picture")
        searchText.delegate = self
        
        request.returnsObjectsAsFaults = false;
        
        do{
            let results = try context.fetch(request)
            if results.count > 0
            {
                data = results as! [NSManagedObject]
            }
        }
        catch
        {
            print("Error")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Function for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      
    // Connect the table view details with table identification and Table view cell
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PictureTableViewCell
        cell.titleLabel.text = data[indexPath.row].value(forKey: "title") as? String
        cell.locationLabel.text = data[indexPath.row].value(forKey: "location") as? String
        cell.dateLabel.text = data[indexPath.row].value(forKey: "date") as? String

        let image = data[indexPath.row].value(forKey: "image") as! NSData
        
        let img = UIImage(data: image as Data)
        cell.imgView.image = img
        
        return cell;
        
    }
    
    //Set the table view rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
    }
    
    // function for the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty {
            let del = UIApplication.shared.delegate as! AppDelegate
            let context = del.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Picture")
            
            request.returnsObjectsAsFaults = false;
            
            do{
                let results = try context.fetch(request)
                if results.count > 0
                {
                    data = results as! [NSManagedObject]
                }else{
                    data.removeAll()
                }
            }
            catch
            {
                print("Error")
            }

        }else{
            let del = UIApplication.shared.delegate as! AppDelegate
            let context = del.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Picture")
            
            // Search for Title
            let predicateTitle = NSPredicate(format: "title contains %@", searchText)
            
            // Search for Location
            let predicateLocation = NSPredicate(format: "location contains %@", searchText)
            
            //Search for Date
            let predicateDate =  NSPredicate(format: "date contains %@" , searchText)
            
            // compundPredicate hold all the predicates that needs to be search
            let compundPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.or, subpredicates: [predicateTitle,predicateLocation, predicateDate])
            
            request.predicate = compundPredicate
            
            request.returnsObjectsAsFaults = false;
            
            do{
                let results = try context.fetch(request)
                if results.count > 0
                {
                    data = results as! [NSManagedObject]
                }
            }
            catch
            {
                print("Error")
            }

        }
        tableview.reloadData()
    }
    

}
