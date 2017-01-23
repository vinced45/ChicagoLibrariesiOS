//
//  MapViewController.swift
//  ChicagoLibrariesiOS
//
//  Created by Vince on 1/21/17.
//  Copyright © 2017 Vince Davis. All rights reserved.
//

import UIKit
import MapKit
import ISHPullUp
import ChicagoLibraryKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rootView: UIView!
    
    public weak var listDelegate: ListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        
        let libraryKit = ChicagoLibraryKit()
        libraryKit.getLibraries() { result in
            switch result {
            case let .success(libraries):
                let pins = self.createPins(libraries)
                self.listDelegate?.loadLibraries(libraries)
                self.mapView.addAnnotations(pins)
                self.mapView.showAnnotations(pins, animated: true)
            case let .error(error):
                print("error - \(error)")
            }
        }
    }
    
    public func show(library: Library) {
        for pin in mapView.annotations {
            if let title = pin.title {
                if title == library.name {
                    mapView.showAnnotations([pin], animated: true)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Methods
extension MapViewController {
    func createPins(_ libraries: [Library]) -> [LibraryPin] {
        var pins: [LibraryPin] = []
        for library in libraries {
            let coor = CLLocationCoordinate2D(latitude: library.lat, longitude: library.lon)
            let pin = LibraryPin(coor, title: library.name, subtitle: library.address)
            pin.library = library
            pins.append(pin)
        }
        
        return pins
    }
}

// MARK: - Map Delegates
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        if let pin = annotation as? LibraryPin {
            let reuseId = "Pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: pin, reuseIdentifier: reuseId)
                pinView?.pinTintColor = #colorLiteral(red: 0.00620989548, green: 0.517801702, blue: 0.8624553084, alpha: 1)
                pinView?.canShowCallout = true
            } else {
                
            }
            
            return pinView
        } else { return nil }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let pin = view.annotation as? LibraryPin
        if let library = pin?.library {
            listDelegate?.scrollTo(library: library)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        
    }
}

// MARK: - ISHPullUpContentDelegate
extension MapViewController: ISHPullUpContentDelegate {
    func pullUpViewController(_ vc: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forContentViewController _: UIViewController) {
        // update edgeInsets
        rootView.layoutMargins = edgeInsets
        
        // call layoutIfNeeded right away to participate in animations
        // this method may be called from within animation blocks
        rootView.layoutIfNeeded()
    }
}
