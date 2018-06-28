//
//  DetailViewController.swift
//  StudentPlannerTool
//
//  Created by joel ureellanah on 19/05/2018.
//  Copyright © 2018 joel ureellanah. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    
    @IBOutlet weak var taskProgressView: taskProgressCircle!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveCalendarTask: UIBarButtonItem!
    @IBOutlet weak var addTask_btn: UIBarButtonItem!
    @IBOutlet weak var editTask_btn: UIBarButtonItem!
    @IBOutlet weak var saveCourseworkToCalendar_btn: UIBarButtonItem!
    @IBOutlet weak var editCoursework_btn: UIBarButtonItem!
    
    
    
    
    var managedObjectContext: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchRequest: NSFetchRequest<Task>!
    var tasks: [Task]!
    
    
    var taskIndex: IndexPath?
    
    func configureView() {
        // Update the user interface for the detail item.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = 100.0
        //self.tableView.separatorStyle = .none
        
        saveCalendarTask.isEnabled = false
        editTask_btn.isEnabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "topDetailView"
        {
            if let topViewController = segue.destination as? topDetailViewViewController {
                topViewController.courseworkName = coursework?.name
                topViewController.moduleName = coursework?.module
                topViewController.weight = coursework?.weight
                topViewController.level = coursework?.level
                topViewController.mark = coursework?.mark
                topViewController.notes = coursework?.notes
                topViewController.dueDate = coursework?.dueDate
                topViewController.startDate = coursework?.startDate
                
                
            }
        }
        
        
        if segue.identifier == "addTask"
        {
            if let addTaskViewController = segue.destination as? addTaskViewController {
                addTaskViewController.currentCoursework = coursework
            }
        }
        
        if segue.identifier == "editCoursework"
        {
            if let editCourseworkViewController = segue.destination as? editCourseworkViewController {
                editCourseworkViewController.courseworkName = coursework?.name
                editCourseworkViewController.moduleName = coursework?.module
                editCourseworkViewController.weight = coursework?.weight
                editCourseworkViewController.level = coursework?.level
                editCourseworkViewController.startDate = coursework?.startDate
                editCourseworkViewController.dueDate = coursework?.dueDate
                editCourseworkViewController.notes = coursework?.notes
            }
        }
        
        if segue.identifier == "editTask"
        {
            if let editTaskViewController = segue.destination as? editTaskViewController {
                editTaskViewController.courseworkName = coursework?.name
                editTaskViewController.taskName = self.fetchedResultsController.fetchedObjects?[(taskIndex?.row)!].name
                editTaskViewController.startDate = self.fetchedResultsController.fetchedObjects?[(taskIndex?.row)!].startDate
                editTaskViewController.dueDate = self.fetchedResultsController.fetchedObjects?[(taskIndex?.row)!].dueDate
                editTaskViewController.notes = self.fetchedResultsController.fetchedObjects?[(taskIndex?.row)!].notes
            }
        }
    }
    
    
    
    
    var coursework: Coursework? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    var task: Task? {
        didSet {
            configureView()
        }
    }
    
    
    @IBAction func saveToCalendar(_ sender: Any) {
        
        
        if (self.coursework?.name != nil || self.coursework?.startDate != nil || self.coursework?.dueDate != nil || self.coursework?.notes != nil) {
            
            let eventStore:EKEventStore = EKEventStore()
            
            eventStore.requestAccess(to: .event, completion: {(granted, error) in
                if (granted) && (error == nil) {
                    print("granted \(granted)")
                    print("error \(String(describing: error))")
                    
                    let event:EKEvent = EKEvent(eventStore: eventStore)
                    
                    event.title = self.coursework?.name
                    
                    event.startDate = self.coursework?.startDate
                    event.endDate = self.coursework?.dueDate
                    event.notes = self.coursework?.notes
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let error as NSError {
                        print("error: \(error)")
                    }
                    print("Save event")
                } else {
                    print("error : \(String(describing: error))")
                }
                
            })
        } else {
            displayAlert(title: "Ops!", message: "Something went wrong. Fill all boxes or select a task.")
        }
        
        
        
        
    }
    
    
    
    
    @IBAction func saveTaskToCalendar(_ sender: Any) {
        
        
        if (self.fetchedResultsController.fetchedObjects?[(self.taskIndex?.row)!].name != nil || self.fetchedResultsController.fetchedObjects?[(self.taskIndex?.row)!].startDate != nil || self.fetchedResultsController.fetchedObjects?[(self.taskIndex?.row)!].dueDate != nil || self.fetchedResultsController.fetchedObjects?[(self.taskIndex?.row)!].notes != nil) {
            
            
            
            let eventStore:EKEventStore = EKEventStore()
            
            eventStore.requestAccess(to: .event, completion: {(granted, error) in
                if (granted) && (error == nil) {
                    print("granted \(granted)")
                    print("error \(String(describing: error))")
                    
                    let event:EKEvent = EKEvent(eventStore: eventStore)
                    
                    event.title = self.fetchedResultsController.fetchedObjects?[(self.taskIndex?.row)!].name
                    
                    event.startDate = self.fetchedResultsController.fetchedObjects?[(self.taskIndex?.row)!].startDate
                    event.endDate = self.fetchedResultsController.fetchedObjects?[(self.taskIndex?.row)!].dueDate
                    event.notes = self.fetchedResultsController.fetchedObjects?[(self.taskIndex?.row)!].notes
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let error as NSError {
                        print("error: \(error)")
                    }
                    print("Save event")
                } else {
                    print("error : \(String(describing: error))")
                }
                
            })
            
            
            
        } else {
            displayAlert(title: "Ops!", message: "Something went wrong. Fill all boxes or select a task.")
        }
        
        
        
        
    }
    
    
    
    
    
    
    // MARK: - tableView delegate section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.delete(self.fetchedResultsController.object(at: indexPath))
            
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! tableCellTableViewCell
//        let title = self.fetchedResultsController.fetchedObjects?[indexPath.row].name
//        cell.courseworkName_lbl.text = title
//
//        let dueDate = self.fetchedResultsController.fetchedObjects?[indexPath.row].dueDate
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd MMMM yyyy"
//        cell.dueDate_lbl.text = formatter.string(from: dueDate!)
//
//        if let notesText = self.fetchedResultsController.fetchedObjects?[indexPath.row].notes
//        {
//            cell.notes_lbl.text = notesText
//        }
//        else {
//            cell.notes_lbl.text = ""
//        }
//
//        let taskProgress = ((1.0 * Double((self.fetchedResultsController.fetchedObjects?[indexPath.row].progress)!)) / 100) - 0.15
//        cell.percentage = taskProgress
//        cell.taskPercentage = self.fetchedResultsController.fetchedObjects?[indexPath.row].progress
        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(_ cell: tableCellTableViewCell, indexPath: IndexPath) {
        //   cell.detailTextLabel?.text = "test label"
        
        let title = self.fetchedResultsController.fetchedObjects?[indexPath.row].name
        cell.courseworkName_lbl.text = title
        
        let dueDate = self.fetchedResultsController.fetchedObjects?[indexPath.row].dueDate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        cell.dueDate_lbl.text = formatter.string(from: dueDate!)
        
        if let notesText = self.fetchedResultsController.fetchedObjects?[indexPath.row].notes
        {
            cell.notes_lbl.text = notesText
        }
        else {
            cell.notes_lbl.text = ""
        }
        
        let taskProgress = ((1.0 * Double((self.fetchedResultsController.fetchedObjects?[indexPath.row].progress)!)) / 100) - 0.15
        cell.percentage = taskProgress
        cell.taskPercentage = self.fetchedResultsController.fetchedObjects?[indexPath.row].progress
        
    }
    
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       print(self.tableView[indexPath.row])
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row number: \(tableView.indexPathForSelectedRow!)")
        taskIndex = tableView.indexPathForSelectedRow!
        
        saveCalendarTask.isEnabled = true
        editTask_btn.isEnabled = true
        saveCourseworkToCalendar_btn.isEnabled = true
        editCoursework_btn.isEnabled = true
    }
    
    
    
    //MARK: - fetch results controller
    
    var _fetchedResultsController: NSFetchedResultsController<Task>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<Task> {
        
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        
        let currentArtist  = self.coursework
        let request:NSFetchRequest<Task> = Task.fetchRequest()
        //simpler version for just getting the albums
        //   let albums:NSSet = (currentArtist?.albums)!
        
        request.fetchBatchSize = 20
        //sort alphabetically
        let albumNameSortDescriptor = NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        //simpler version
        //   albums.sortedArray(using: [albumNameSortDescriptor])
        
        
        request.sortDescriptors = [albumNameSortDescriptor]
        //we want the albums for the recordArtist - via the relationship
        if(self.coursework != nil){
            let predicate = NSPredicate(format: "forCoursework = %@", currentArtist!)
            request.predicate = predicate
        }
        else {
            //just do all albums for the first artist in the list
            //replace this to get the first artist in the record
            let predicate = NSPredicate(format: "coursework = %@","")
            request.predicate = predicate
            
            
        }
        let frc = NSFetchedResultsController<Task>(
            fetchRequest: request,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: #keyPath(Task.coursework),
            cacheName:nil)
        frc.delegate = self
        _fetchedResultsController = frc
        
        do {
            //    try frc.performFetch()
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        
        return frc as! NSFetchedResultsController<NSFetchRequestResult> as! NSFetchedResultsController<Task>
    }//end var
    
    //MARK: - fetch results table view functions
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    //must have a NSFetchedResultsController to work
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case NSFetchedResultsChangeType(rawValue: 0)!:
            // iOS 8 bug - Do nothing if we get an invalid change type.
            break
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.configureCell(tableView.cellForRow(at: indexPath!)! as! tableCellTableViewCell, indexPath: newIndexPath!)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
            //    default: break
            
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
        // self.tableView.reloadData()
    }
    
    
    
    
    //Alert Message
    func displayAlert(title: String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert,animated: true, completion: nil)
    }
    
    
    func reloadT() {
        tableView.reloadData()
    }

    
    

}

