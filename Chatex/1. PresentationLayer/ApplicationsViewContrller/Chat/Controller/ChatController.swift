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
    
    
    
    @IBAction func lolkekPressed(_ sender: Any) {
        
        let originHeight = sendButton.frame.size.height
        let originWidth = sendButton.frame.size.width
        let originSizeFont = customTitleView.font
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                
                self.sendButton.frame.size.height += self.sendButton.frame.size.height * 15.0 / 100.0
                self.sendButton.frame.size.width += self.sendButton.frame.size.width * 15.0 / 100.0
                self.customTitleView.font = self.customTitleView.font.withSize(24)
                
            })
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5, animations: {
                self.sendButton.frame.size.height = originHeight
                self.sendButton.frame.size.width = originWidth
                self.customTitleView.font = originSizeFont
            })
        }, completion: nil)
        
    }
}

extension ChatController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? InputMessageCell
        return cell ?? UITableViewCell()
    }
    
    
}


extension ChatController: UITableViewDelegate {
    
}
