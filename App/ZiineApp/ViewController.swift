//
//  ViewController.swift
//  ZiineApp
//
//  Created by Geon Woo lee on 1/25/25.
//

import UIKit
import ArtworkFeature
import ArtworkFeatureInterface

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let btn = UIButton()
        btn.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        btn.setTitle("button", for: .normal)
        
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.backgroundColor = .orange
    }
    
    @objc func didTap() {
        push()
    }

    func push() {
        let builder = ArtworkViewBuilder(navigationController: self.navigationController!)
        let routing = builder.build(withListener: nil)
        let viewContorller = routing
//
        print(#function, self.navigationController, routing.viewController)
//        
        self.present(routing.viewController!, animated: true)
    }
}

