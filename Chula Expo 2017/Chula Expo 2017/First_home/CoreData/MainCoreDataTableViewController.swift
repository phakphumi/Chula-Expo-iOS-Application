//
//  CoreDataTableViewController.swift
//
//  Created by CS193p Instructor.
//  Copyright © 2015-16 Stanford University. All rights reserved.
//

import UIKit
import CoreData

class MainCoreDataTableViewController: UITableViewController, NSFetchedResultsControllerDelegate
{
//    var fetchedResultsControllerStage1: NSFetchedResultsController<NSFetchRequestResult>? {
//        didSet {
//            do {
//                if let frc = fetchedResultsControllerStage1 {
//                    frc.delegate = self
//                    try frc.performFetch()
//                }
//                tableView.reloadData()
//            } catch let error {
//                print("NSFetchedResultsControllerStage1.performFetch() failed: \(error)")
//            }
//        }
//    }
//    
//    var fetchedResultsControllerStage2: NSFetchedResultsController<NSFetchRequestResult>? {
//        didSet {
//            do {
//                if let frc = fetchedResultsControllerStage2 {
//                    frc.delegate = self
//                    try frc.performFetch()
//                }
//                tableView.reloadData()
//            } catch let error {
//                print("NSFetchedResultsControllerStage2.performFetch() failed: \(error)")
//            }
//        }
//    }
//    
//    var fetchedResultsControllerStage3: NSFetchedResultsController<NSFetchRequestResult>? {
//        didSet {
//            do {
//                if let frc = fetchedResultsControllerStage3 {
//                    frc.delegate = self
//                    try frc.performFetch()
//                }
//                tableView.reloadData()
//            } catch let error {
//                print("NSFetchedResultsControllerStage3.performFetch() failed: \(error)")
//            }
//        }
//    }
    
    var fetchedResultsControllerFeed: NSFetchedResultsController<NSFetchRequestResult>? {
        didSet {
            do {
                if let frc = fetchedResultsControllerFeed {
                    frc.delegate = self
                    try frc.performFetch()
                }
                tableView.reloadData()
            } catch let error {
                print("NSFetchedResultsControllerFeed.performFetch() failed: \(error)")
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
//            if let i = fetchedResultsController?.sections?[0]{
//                return i.numberOfObjects+1
//            }
            return 3
        }
        else if section == 2{
            if let i = fetchedResultsControllerFeed?.sections?[0]{
//                print("Number of feed cell = \(i.numberOfObjects)")
                return i.numberOfObjects+1
            }
            print("section 2 else")
            return 0
        }
        else {
//            print("else \(fetchedResultsController)")
            return 0
        }
    }
    
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return fetchedResultsController?.sectionIndexTitles
//    }
//    
//    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        return fetchedResultsController?.section(forSectionIndexTitle: title, at: index) ?? 0
//    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert: tableView.insertSections(IndexSet(integer: sectionIndex+2), with: .fade)
        case .delete: tableView.deleteSections(IndexSet(integer: sectionIndex+2), with: .fade)
        default: break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        if controller == fetchedResultsControllerFeed{
            var newIndex = IndexPath()
            var index = IndexPath()
            
            if newIndexPath != nil {
                newIndex = IndexPath(row: newIndexPath!.row+1, section: newIndexPath!.section + 2)
            }
            
            if indexPath != nil {
                index = IndexPath(row: indexPath!.row+1, section: indexPath!.section + 2)
            }
            
            switch type {
            case .insert:
                tableView.insertRows(at: [newIndex], with: .fade)
            case .delete:
                tableView.deleteRows(at: [index], with: .fade)
            case .update:
                tableView.reloadRows(at: [index], with: .fade)
            case .move:
                tableView.deleteRows(at: [index], with: .fade)
                tableView.insertRows(at: [newIndex], with: .fade)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            tableView.endUpdates()
    }
}

