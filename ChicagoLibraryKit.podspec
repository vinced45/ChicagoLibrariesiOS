Pod::Spec.new do |s|

  s.name                        = "ChicagoLibraryKit"
  s.version                     = "0.0.1"
  s.summary                     = "This is a framework for Chicago Libraries"
  s.description                 = "You can use this framework to find info about Chicago ibraries"
  s.homepage                    = "https://github.com/vinced45/ChicagoLibrariesiOS"
  # s.screenshots               = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license                     = { :type => "MIT", :file => "LICENSE" }

  s.author                      = { "Vince Davis" => "Vince.Davis@me.com" }
  s.social_media_url            = "http://twitter.com/vincedavis"

  s.ios.deployment_target       = "10.0"
  s.osx.deployment_target       = "10.12"
  s.watchos.deployment_target   = "3.0"
  s.tvos.deployment_target      = "10.0"

  s.source                      = { :git => "https://github.com/vinced45/ChicagoLibrariesiOS.git", :tag => s.version.to_s }

  s.source_files                = ["ChicagoLibraryKit/*.{swift,h,m}", "ChicagoLibraryKit/**/*.{swift,h,m}"]

  s.frameworks                  = "CoreLocation", "Foundation", "MapKit"

  s.requires_arc                = true

  s.dependency                  'RealmSwift', '~> 2.0.0'
  s.dependency                  'SwiftyJSON'

end
