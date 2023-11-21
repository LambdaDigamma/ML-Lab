//
//  MenuListViewController.swift
//  ML Playground
//
//  Created by Lennart Fischer on 03.11.23.
//

import UIKit

class MenuListViewController: UIViewController {

    // MARK: - UIViewController Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        
    }
    
    // MARK: - UI -
    
    private func setupUI() {
        
        self.addSubSwiftUIView(MenuListView(onAction: showMenuItem(_:)), to: view)
        
    }
    
    private func showMenuItem(_ item: MenuItem) {
        
        if item.type == .classification {
            
            let imageController = ImageClassificationViewController(
                model: item.appModel
            )
            
            self.navigationController?.pushViewController(imageController, animated: true)
            
        } else {
            
            let viewController = ObjectDetectionViewController()
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    
}
