# polylineEncoder
<b>Swift implementation of the google's polyline algorithm</b>
https://developers.google.com/maps/documentation/utilities/polylinealgorithm<br/>
Source of code: https://github.com/dionysis560/polylineAlgorithm

<b>USE</b><br/>

        var path: GMSPath... // The path that describes a polyline. 
        mapView.clear() // Clear Google Map

        let pline = PolyLineEncoder() 
        for index in 0 ..< path.count() - 1 {
            let coordinate = path.coordinate(at: index) 
            pline.addPoint(lat: coordinate.latitude, lon: coordinate.longitude) 
        }
        pline.encode() // Encode path to String
        print(pline.toString()) // Show encoded string of polyline

        // Demo create polygon from this path
        let pathNew = GMSPath(fromEncodedPath: pline.toString())
        let polygon = GMSPolygon(path: pathNew)
        polygon.map = mapView
