//
//  ConversationsController.swift
//  FireChat
//
//  Created by Richard J on 25/04/21.
//

import UIKit
import Firebase

private let resuseIndetifier = "conversationsCell"

class ConversationsController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    
    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        configureUI()
        authenticateUser()
        
    }
    
    // MARK: - Selectors
    
    @objc func showProfile(){
        print("show profile")
        do {
            try Auth.auth().signOut()
            self.presentLoginController()
        } catch  {
            print("DEBUG: Error signing out")
        }
    }

    // MARK: - Helpers
    
    fileprivate func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func authenticateUser()  {
        if (Auth.auth().currentUser?.uid == nil){
         presentLoginController()
        }
    }
        
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}


extension ConversationsController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: resuseIndetifier, for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row)"
        return cell
    }
    
    
}

extension ConversationsController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row \(indexPath.row)")
    }
    
}


