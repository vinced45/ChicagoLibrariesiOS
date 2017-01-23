//
//  LibraryPin.swift
//  ChicagoLibrariesiOS
//
//  Created by Vince on 1/22/17.
//  Copyright © 2017 Vince Davis. All rights reserved.
//

import MapKit
import CoreLocation
import ChicagoLibraryKit

public class LibraryPin: NSObject, MKAnnotation {
    public var title: String?
    public var subtitle: String?
    public var coordinate: CLLocationCoordinate2D
    public var library: Library?
    
    public init(_ coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
