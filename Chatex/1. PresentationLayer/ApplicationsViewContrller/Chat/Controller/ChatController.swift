//
//  ChatController.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 18/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import UIKit

class ChatController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    
    var locationTap: CGPoint?
    var tap: UILongPressGestureRecognizer!
    let emitter = CAEmitterLayer()
   
    let animator = Animator()
    
    private let identifier = String(describing: InputMessageCell.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "wall"))
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    let customTitleView = UILabel()
    
    func setupViews() {
        customTitleView.text = "Oksana Dogina"
        customTitleView.textColor = .white
        navigationItem.titleView = customTitleView
        setupLongGesture()
        sendButton.layer.cornerRadius = 19
        sendButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        sendButton.layer.masksToBounds = true
    }
    

    func setupLongGesture() {
        tap = UILongPressGestureRecognizer(target: self, action: #selector(trackingTap))
        tap.minimumPressDuration = 0.5
        self.view.addGestureRecognizer(tap)
    }
    
    
    @objc func trackingTap(gestureTap: UITapGestureRecognizer)  {
        
        switch gestureTap.state {
        case .began:
            locationTap = gestureTap.location(in: gestureTap.view)
            view.layer.addSublayer(animator.startMeaninglessLove(emitter: emitter, tap: locationTap ?? CGPoint()))
        case .ended:
            animator.stopMeaninglessLove(emitter: emitter)
        default:
            locationTap = gestureTap.location(in: gestureTap.view)
            view.layer.addSublayer(animator.startMeaninglessLove(emitter: emitter, tap: locationTap ?? CGPoint()))
            
        }
    }
    
    
    
   
}

extension ChatController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? InputMessageCell
        return cell ?? UITableViewCell()
    }
    
    
}


extension ChatController: UITableViewDelegate {
    
}
