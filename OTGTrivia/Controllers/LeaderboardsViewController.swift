//
//  LeaderboardsViewController.swift
//  OTGTrivia
//
//  Created by Julio Reyes on 4/10/19.
//  Copyright © 2019 Julio Reyes. All rights reserved.
//

import UIKit

class LeaderboardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count > 0 ? self.tableData.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let currentPlayer = self.tableData[indexPath.row]
        cell.textLabel?.text = currentPlayer.playerName
        cell.detailTextLabel?.text = String(currentPlayer.playerScore)
        return cell
    }
    @IBOutlet weak var leaderboardTableView: UITableView!
    
    var tableData: [Player] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.leaderboardTableView.dataSource = self
        self.leaderboardTableView.delegate = self
        

        if let loadedPlayers = NSKeyedUnarchiver.unarchiveObject(withFile: leaderboardFilePath) as? [Player]{
                self.tableData = loadedPlayers
        }

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
