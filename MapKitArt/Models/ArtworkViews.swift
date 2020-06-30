//
//  ArtworkViews.swift
//  MapKitArt
//
//  Created by Denis Abramov on 25.05.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import Foundation
import MapKit

// Markers with Color-Coding and Text
class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = artwork.markerTintColor

            glyphImage = artwork.image
        }
    }
}

// Annotations with Images
class ArtworkView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)

            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 48,
                                                                 height: 48)))
            mapsButton.setBackgroundImage(#imageLiteral(resourceName: "Map"), for: .normal)
            rightCalloutAccessoryView = mapsButton
            
            image = artwork.image
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = artwork.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}
