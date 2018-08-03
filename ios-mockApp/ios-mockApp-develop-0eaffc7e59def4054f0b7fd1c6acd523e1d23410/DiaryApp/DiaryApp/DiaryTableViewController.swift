//
//  DiaryTableViewController.swift
//  DiaryApp
//
//  Created by ailesdor on 2018/06/07.
//  Copyright © 2018年 ailesdor. All rights reserved.
//

import UIKit

class DiaryTableViewController: UITableViewController {

    let userDefaults = UserDefaults.standard
    
    var diarys = [[String:String]]()
    
    @IBAction func unwindToDiaryList(sender: UIStoryboardSegue) {
        guard let sourceVC = sender.source as? ViewController, let title = sourceVC.dTitle, let content = sourceVC.dContent else {
            return
        }
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.diarys[selectedIndexPath.row] = ["title":title,"content":content,"date":self.getToday()]
        } else {
            self.diarys.append(["title":title,"content":content,"date":self.getToday()])
        }
        
        self.userDefaults.set(self.diarys, forKey: "diarys")
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var today = self.getToday()
        
        var emptyDiary = [
            ["title":"Welcome this diary app",
             "content": "you can write diary from this application","date":today]
        ]
        
        if self.userDefaults.object(forKey: "diarys") != nil {
            self.diarys = self.userDefaults.object(forKey: "diarys") as! [[String:String]]
        } else {
            self.diarys = emptyDiary
        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return self.diarys.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryTableViewCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.diarys.reversed()[indexPath.row]["title"]
        cell.detailTextLabel?.text = self.diarys.reversed()[indexPath.row]["date"]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.diarys.remove(at: indexPath.row)
            self.userDefaults.set(self.diarys, forKey: "diarys")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

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
        
        guard let identifier = segue.identifier else{
            return
        }
        if identifier == "editDiary" {
            let viewController = segue.destination as! ViewController
            viewController.dTitle = self.diarys.reversed()[(self.tableView.indexPathForSelectedRow?.row)!]["title"]
            viewController.dContent = self.diarys.reversed()[(self.tableView.indexPathForSelectedRow?.row)!]["content"]
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func getToday(format:String = "yyyy/MM/dd") -> String {
        
        let now = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
}
