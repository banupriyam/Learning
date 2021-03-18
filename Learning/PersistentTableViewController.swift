//
//  PersistentTableViewController.swift
//  Learning
//
//  Created by Banu on 17/03/21.
//

import UIKit
import CoreData

class PersistentTableViewController: UITableViewController {
    
    @IBOutlet var persistentTableView: UITableView!
//    var names: [String] = []
    var persons: [Person] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = " Students Name List "
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Person")
      
      //3
      do {
        persons = try managedContext.fetch(fetchRequest) as! [Person]
      } catch {
        print("Could not fetch. \(error)")
      }
    }

    
    
    @IBAction func addNameAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Name", message: "Add a New Name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: " Save", style: .default) { action in
            
            guard let textField = alert.textFields?.first,
                  let nameToSave = textField.text else {
                return
            }
            //self.name.append(nameToSave)
            //self.persistentTableView.reloadData()
            self.saveName(name: nameToSave)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)

    }
    
    func saveName(name: String){
        
        guard let appDelegate =
           UIApplication.shared.delegate as? AppDelegate else {
           return
         }
         
         let managedContext =
           appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
          
          let person = NSManagedObject(entity: entity,
                                       insertInto: managedContext) as! Person
        
        person.name = name
        person.addedDate = Date()
        do {
            try managedContext.save()
            persons.append(person)
            persistentTableView.reloadData()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }
    
}

extension PersistentTableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "PersistentTableViewCellId",
                                          for: indexPath)
        cell.textLabel?.text = persons[indexPath.row].name
        cell.detailTextLabel?.text = persons[indexPath.row].addedDate?.description
        return cell
    }
    
}


