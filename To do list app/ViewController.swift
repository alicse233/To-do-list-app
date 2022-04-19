//
//  ViewController.swift
//  To do list app
//
//  Created by sreelekh N on 19/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableV: UITableView!
    
    var tasks = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"

        tableV.dataSource = self
        tableV.delegate = self
        
        
        if !UserDefaults().bool(forKey: "setUp") {
            UserDefaults().set(true, forKey: "setUp")
            UserDefaults().set(0, forKey: "count")
        }
        
        //load tasks
        updateTaskList()
    }
    
    func updateTaskList() {
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
            
        }
        
        tableV.reloadData()
    
    }

    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        vc.title = "New Task"
    
        vc.update = {
            DispatchQueue.main.async {
                self.updateTaskList()
            }
            
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskInfoViewController
        
        vc.title = "Task"
        
        vc.taskTitle = tasks[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
    
}


