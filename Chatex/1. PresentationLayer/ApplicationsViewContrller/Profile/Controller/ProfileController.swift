//
//  ViewController.swift
//  doOrGoToPyaterochka
//
//  Created by  Евгений on 15/11/2018.
//  Copyright © 2018 LosAnatoly Inc. All rights reserved.
//

import UIKit



class ProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CanReceive {
    
    func dataReceived(data: UIImage) {
        photoView.image = data
        saveUseCoreData()
    }
    
   
    
    @IBOutlet weak var editingButton: UIButton!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var editingButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomViewHeigh: NSLayoutConstraint!
    @IBOutlet weak var blurEffect: UIVisualEffectView!
    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoButton: UIButton!
    
    private enum State {
        case closed
        case open
        
        var opposite: State {
            return self == .open ? .closed : .open
        }
    }
    private var state: State = .closed
    private var runningAnimators: [UIViewPropertyAnimator] = []
    private var viewOffset: CGFloat = 250
    
    private var storageManager = CoreDataManager()
    private var isEditingState = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        storageManager.read { (name, about, image) in
            self.nameTextField.text = name
            self.aboutTextView.text = about
            self.photoView.image = image
        }
    }
    
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func animateView(to state: State, duration: TimeInterval) {
        
        guard runningAnimators.isEmpty else { return }
        
        let basicAnimator = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: nil)
        
        basicAnimator.addAnimations {
            switch state {
            case .open:
                self.bottomViewHeigh.constant = self.viewOffset
                self.topViewConstraint.constant = self.viewOffset + 10
                self.editingButtonConstraint.constant = 10
            case .closed:
                self.bottomViewHeigh.constant = 0
                self.topViewConstraint.constant = 0
                self.editingButtonConstraint.constant = -60
            }
            
            self.view.layoutIfNeeded()
            
        }
        
        let blurAnimator = UIViewPropertyAnimator(duration: duration, controlPoint1: CGPoint(x: 0.8, y: 0.2), controlPoint2: CGPoint(x: 0.8, y: 0.2)) {
            switch state {
            case .open:
                self.blurEffect.effect = UIBlurEffect(style: .light)
            case .closed:
                self.blurEffect.effect = nil
            }
        }
        blurAnimator.scrubsLinearly = false
        
        blurAnimator.addCompletion { (animator) in
            self.runningAnimators.removeAll()
            self.state = self.state.opposite
        }
        
        runningAnimators.append(basicAnimator)
        runningAnimators.append(blurAnimator)
    }
    
    
    private func setupViews() {
        
        stateOfFields(isState: false)
        
        bottomView.layer.cornerRadius = 15
        bottomView.layer.masksToBounds = true
        topView.layer.cornerRadius = 15
        topView.layer.masksToBounds = true
        bottomViewHeigh.constant = 0
        topViewConstraint.constant = 0
        editingButtonConstraint.constant = -60
        
        blurEffect.effect = nil
        blurEffect.isHidden = false
        view.layoutIfNeeded()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.onDrag(_:)))
        topView.addGestureRecognizer(panGesture)
        
    }
    
    @objc func onDrag(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            animateView(to: state.opposite, duration: 0.4)
        case .changed:
            let translation = gesture.translation(in: topView)
            let fraction = abs(translation.y / viewOffset)
            
            runningAnimators.forEach { (animator) in
                animator.fractionComplete = fraction
            }
        case .ended:
            runningAnimators.forEach{ $0.continueAnimation(withTimingParameters: nil, durationFactor: 0) }
        default:
            break
        }
    }
    
    //MARK: UIImagePickerController methods
    
    @IBAction func photoButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheed = UIAlertController(title: "Select source", message: nil, preferredStyle: .actionSheet)
        
        actionSheed.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera is not available")
            }
        }))
        
        actionSheed.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        

        actionSheed.addAction(UIAlertAction(title: "Network", style: .default, handler: { (action) in
            let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as? PhotoController
            vc?.delegate = self
            self.present(vc!, animated: true, completion: nil)
        }))
        
        actionSheed.addAction(UIAlertAction(title: "Cancel ", style: .cancel, handler: nil))
        
        self.present(actionSheed, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func unsuccessfulAlert(){
        let alert = UIAlertController(title: "Ooops", message: "Smt were wrong", preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        let again = UIAlertAction(title: "Try again", style: .default) { (action) in
            self.saveUseCoreData()
        }
        alert.addAction(again)
        alert.addAction(alertOk)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveUseCoreData() {
        
        storageManager.save(name: nameTextField.text, about: aboutTextView.text, image: photoView.image) { (done) in
            if done {
                print("Saved")
            } else {
                self.unsuccessfulAlert()
            }
        }
    }
    
    func stateOfFields(isState: Bool) {
        nameTextField.isEnabled = isState
        aboutTextView.isEditable = isState
    }
    
    @IBAction func editingButtonTapped(_ sender: Any) {
        if isEditingState {
            editingButton.setTitle("Save", for: .normal)
            stateOfFields(isState: true)
            isEditingState = !isEditingState

        } else {
            editingButton.setTitle("Edit", for: .normal)
            stateOfFields(isState: false)
            
            saveUseCoreData()
            isEditingState = !isEditingState

        }
    }
}


