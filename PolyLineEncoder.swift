//
//  PolyLineEncoder.swift
//  DottedPolyline
//
//  Created by Valery on 30.01.2018.
//  Copyright © 2018 dylanmaryk. All rights reserved.
//

import Foundation
import CoreGraphics

//typealias point = CLLocationCoordinate2D

class PolyLineEncoder {

    private var points = [Point]()
    private var encoded_points = "";

    init() {
        points.removeAll()
        encoded_points = "";
    }

    public func addPoint(lat: Double, lon: Double) {
        points.append(Point(lat: lat, lon: lon))
    }

    public func encode() {
        var prevPoint = Point(lat: 0.0, lon: 0.0)
        for point in points {
            encoded_points += encodePoint(prevPoint, point: point)
            prevPoint = point
        }
    }

    public func clear(){
        points.removeAll()
        encoded_points = ""
    }

    private func encodePoint(_ prevPoint: Point, point: Point) -> String {
        let late5 = CLong(ceil(point.lat * 1e5))
        let plate5 = CLong(ceil(prevPoint.lat * 1e5))
        let lnge5 = CLong(ceil(point.lon * 1e5))
        let plnge5 = CLong(ceil(prevPoint.lon * 1e5))
        let dlng = lnge5 - plnge5;
        let dlat = late5 - plate5;
        return encodeSignedNumber(dlat) + encodeSignedNumber(dlng);
    }

    private func encodeSignedNumber(_ num: CLong) -> String {
        var sgn_num = (num << 1);
        if (num < 0) {
            sgn_num = ~sgn_num;
        }
        return(encodeNumber(sgn_num));
    }

    private func encodeNumber(_ num: CLong) -> String {
        var num = num
        var encodeString = "";
        while (num >= 0x20) {
            let c = String(format: "%c",(0x20 | (num & 0x1f)) + 63);
            encodeString += c;
            num >>= 5;
        }
        let c2 = String(format: "%c",num + 63);
        encodeString += c2;
        return encodeString;
    }

    public func toString() -> String {
        return encoded_points;
    }

    class Point{
        var lat:Double, lon:Double

        public init(lat:Double, lon:Double){
            self.lat = lat
            self.lon = lon
        }

        public init(p: Point) {
            self.lat=p.lat;
            self.lon=p.lon;
        }


        public func getLat() -> Double {
            return lat;
        }

        public func getLon() -> Double {
            return lon;
        }

    }
}
