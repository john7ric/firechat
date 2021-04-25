//
//  ConversationsController.swift
//  FireChat
//
//  Created by Richard J on 25/04/21.
//

import UIKit

private let resuseIndetifier = "conversationsCell"

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        configureUI()
        
    }
    
    
    // MARK: - Selectors
    
    @objc func showProfile(){
        print("show profile")
    }

    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        configureNavigationBar()
        configureTableView()
        }
    
    func configureNavigationBar() {
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        appearence.backgroundColor = .systemPurple
        
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        navigationController?.navigationBar.standardAppearance = appearence

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.title = "Messages"
        let image = UIImage(systemName: "person.circle.fill")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        
    }
    
    func configureTableView(){
        
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:resuseIndetifier)
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        
    }
}


