//
//  DashboardViewController.swift
//  iOS Interview
//
//  Created by Kasiti Ketwattha on 4/10/2563 BE.
//  Copyright © 2563 Kasiti Ketwattha. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var footerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
    }
    
    private func setupInterface() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefault.logout(vc: self)
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefault.shared().responseData?.customers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableViewCell") as! DashboardTableViewCell
        cell.idLabel.text = UserDefault.shared().responseData?.customers[indexPath.row].id
        cell.nameLabel.text = UserDefault.shared().responseData?.customers[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CustomerDetailViewControllerID") as! CustomerDetailViewController
        vc.token = UserDefault.shared().responseData?.token ?? ""
        vc.id = UserDefault.shared().responseData?.customers[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
}
