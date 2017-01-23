//
//  ChicagoLibraryKit.swift
//  ChicagoLibrariesiOS
//
//  Created by Vince on 1/21/17.
//  Copyright © 2017 Vince Davis. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON
import RealmSwift

@objc
public class ChicagoLibraryKit: NSObject {

    // MARK: Properties
    let apiURL = "https://data.cityofchicago.org/resource/x8fc-8rcq.json"
    
    // MARK: Enums
    public enum LibraryResult {
        case success([Library])
        case error(Error)
    }
    
    public typealias LibraryClosure = (_ result: LibraryResult) -> Void
    
    // MARK: Public Methods
    
    /**
     This method will get libraries from the url

     - Returns: Array of `Library` Objects
     */
    public func getLibraries(completion: @escaping LibraryClosure) {
        if let results = db.query(Library.self) {
            if results.count > 0 {
                let libraries: [Library] = results.map { $0 }
                completion(LibraryResult.success(libraries))
                return
            }
        }
        
        network.call(apiURL) { result in
            switch result {
            case let .downloadCompleted(_, data):
                let json = JSON(data: data)
                self.saveLibraries(json) { libraryResult in
                    switch libraryResult {
                    case let .success(libraries):
                        completion(LibraryResult.success(libraries))
                    default:
                        completion(LibraryResult.error(LibraryError.default()))
                    }
                }
            case let .error(error):
                completion(LibraryResult.error(error))
            default:
                completion(LibraryResult.error(LibraryError.default()))
            }
        }
    }
}

// MARK: Private Methods
extension ChicagoLibraryKit {
    internal func saveLibraries(_ jsonArray: JSON?, completion: @escaping LibraryClosure) {
        var libraries: [Library] = []
        
        guard let jsons = jsonArray?.array else  {
            completion(LibraryResult.error(LibraryError.default()))
            return
        }
        
        for json in jsons {
            let library = Library()
            library.id = json["name_"].stringValue
            library.state = json["state"].stringValue
            library.zip = json["zip"].stringValue
            library.website = json["website"]["url"].stringValue
            library.address = json["address"].stringValue
            library.city = json["city"].stringValue
            library.phone = json["phone"].stringValue
            library.cybernavigator = json["cybernavigator"].stringValue
            library.hoursOfOperation = json["hours_of_operation"].stringValue
            library.name = json["name_"].stringValue
            library.teacherInTheLibrary = json["teacher_in_the_library"].stringValue
            library.updatedAt = Date()
            library.lat = json["location"]["latitude"].doubleValue
            library.lon = json["location"]["longitude"].doubleValue
            libraries.append(library)
        }
        db.add(libraries)
        completion(LibraryResult.success(libraries))
    }
}
