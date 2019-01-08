//
//  ConversationsController.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import UIKit

class ConversationsController: UIViewController {
    
    //TODO: Найти адекватный цвет для навигейшена, возможно сделать иконку стрелочки на ячейке чуть заметнее
    
    @IBOutlet weak var tableView: UITableView!
    
    private let MCManager = MultipeerManager()
    private let identifier = String(describing: ConversationCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        setupNavigationBar()
        MCManager.partyTime()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        let profileButton = UIButton()
        profileButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        profileButton.setImage(#imageLiteral(resourceName: "profileIcon").withRenderingMode(.alwaysOriginal), for: .normal)
        profileButton.contentMode = .scaleAspectFill
        //        profileButton.imageView?.makeCircle()
        profileButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }
    
    @objc func buttonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
        self.present(viewController, animated: true, completion: nil)
        
        if let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileController
        {
            present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    
    
}

extension ConversationsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ConversationCell
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        guard let vc = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as? ChatController else { return }
        vc.navigationItem.title = "Oksans Dogina"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ConversationsController: UITableViewDelegate {}


