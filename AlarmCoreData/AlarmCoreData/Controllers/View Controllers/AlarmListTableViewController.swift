//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by Tiffany Sakaguchi on 4/29/21.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedInstance.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell") as? AlarmTableViewCell else { return UITableViewCell() }
        
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
               
        cell.delegate = self
        cell.updateViews(alarm: alarm)
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? AlarmDetailTableViewController,
                  let indexPath = tableView.indexPathForSelectedRow else { return }
            let alarmToSend = AlarmController.sharedInstance.alarms[indexPath.row]
            destinationVC.alarm = alarmToSend
        }
    }
}//End of class

//MARK: - Extensions

extension AlarmListTableViewController: AlarmTableViewCellDelegate {
    func alarmWasToggled(sender: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        //sender.alarm - alt method to create a didSet
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.toggleIsEnabledFor(alarm: alarm)
        sender.updateViews(alarm: alarm)
    }
}//End of extension
