//
//  MainViewController.swift
//  ChicagoLibrariesiOS
//
//  Created by Vince on 1/21/17.
//  Copyright © 2017 Vince Davis. All rights reserved.
//

import UIKit
import ISHPullUp

class MainViewController: ISHPullUpViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    private func commonInit() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = storyBoard.instantiateViewController(withIdentifier: "map") as! MapViewController
        let listVC = storyBoard.instantiateViewController(withIdentifier: "list") as! ListViewController
        contentViewController = mapVC
        bottomViewController = listVC
        listVC.pullUpController = self
        mapVC.listDelegate = listVC
        listVC.mapDelegate = mapVC
        contentDelegate = mapVC
        sizingDelegate = listVC
        stateDelegate = listVC
    }
}
