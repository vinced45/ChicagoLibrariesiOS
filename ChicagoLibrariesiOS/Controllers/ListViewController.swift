//
//  ListViewController.swift
//  ChicagoLibrariesiOS
//
//  Created by Vince on 1/21/17.
//  Copyright © 2017 Vince Davis. All rights reserved.
//

import UIKit
import ISHPullUp
import MapKit
import ChicagoLibraryKit
import SafariServices

class ListViewController: UIViewController {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var handleView: ISHPullUpHandleView!
    @IBOutlet weak var tableView: UITableView!
    
    var firstAppearanceCompleted = true
    weak var pullUpController: ISHPullUpViewController!
    
    var list: [Library] = []
    
    weak var mapDelegate: MapViewController?
    
    // we allow the pullUp to snap to the half way point
    var halfWayPoint = CGFloat(0)

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        handleView.addGestureRecognizer(tapGesture)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private dynamic func handleTapGesture(gesture: UITapGestureRecognizer) {
        if pullUpController.isLocked {
            return
        }
        
        pullUpController.toggleState(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func loadLibraries(_ libraries: [Library]) {
        list = libraries
        tableView.reloadData()
    }
    
    public func scrollTo(library: Library) {
        for (index, lib) in list.enumerated() {
            if lib.id == library.id {
                let path = IndexPath(row: index, section: 0)
                tableView.scrollToRow(at: path, at: .top, animated: true)
                tableView.selectRow(at: path, animated: true, scrollPosition: .top)
                //tableView.deselectRow(at: path, animated: true)
            }
        }
    }
}


extension ListViewController {
    
}

// MARK: - Tableview data source & delegate
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //if cell == nil {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //}
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        let library = list[indexPath.row]
        
        cell.textLabel?.text = library.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        let hours = library.hoursOfOperation.replacingOccurrences(of: ";", with: "")
        
        let black = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 11)]
        let gray = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont.systemFont(ofSize: 11)]
        let label = NSMutableAttributedString(string: "Hours Open: ", attributes: black)
        let value = NSMutableAttributedString(string: hours, attributes: gray)
        let combination = NSMutableAttributedString()
        combination.append(label)
        combination.append(value)
        
        cell.detailTextLabel?.numberOfLines = 3
        cell.detailTextLabel?.attributedText = combination
        
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let library = list[indexPath.row]
        if let url = URL(string: library.website) {
            let svc = SFSafariViewController(url: url)
            self.present(svc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let library = list[indexPath.row]
        mapDelegate?.show(library: library)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        pullUpController.toggleState(animated: true)
    }
}

// MARK: - ISHPullUpSizingDelegate
extension ListViewController: ISHPullUpSizingDelegate {
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
        let totalHeight = rootView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        // we allow the pullUp to snap to the half way point
        // we "calculate" the cached value here
        // and perform the snapping in ..targetHeightForBottomViewController..
        halfWayPoint = totalHeight / 2.0
        return totalHeight
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {
        return 86.0
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
        // if around 30pt of the half way point -> snap to it
        if abs(height - halfWayPoint) < 30 {
            return halfWayPoint
        }
        
        // default behaviour
        return height
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forBottomViewController bottomVC: UIViewController) {
        // we update the scroll view's content inset
        // to properly support scrolling in the intermediate states
        tableView.contentInset = edgeInsets;
    }
}

// MARK: - ISHPullUpStateDelegate
extension ListViewController: ISHPullUpStateDelegate {
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
        
        handleView.setState(ISHPullUpHandleView.handleState(for: state), animated: firstAppearanceCompleted)
    }
    
    private func textForState(_ state: ISHPullUpState) -> String {
        switch state {
        case .collapsed:
            return "Drag up or tap"
        case .intermediate:
            return "Intermediate"
        case .dragging:
            return "Hold on"
        case .expanded:
            return "Drag down or tap"
        }
    }
}
