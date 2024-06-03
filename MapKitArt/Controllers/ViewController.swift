//
//  ViewController.swift
//  MapKit
//
//  Created by Denis Abramov on 24.05.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit
import MapKit

// MARK: - ViewController

class ViewController: UIViewController {
	
	// MARK: UI Elements
	
	@IBOutlet private var mapView: MKMapView!
	
	// MARK: Properties
	
	private var artworks: [Artwork] = []
	
	// MARK: Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initialLocation()
		
		mapView.delegate = self
		
		// Annotations with Images
		mapView.register(
			ArtworkView.self,
			forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier
		)
		
		loadInitialData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		mapView.addAnnotations(artworks)
		configureMapView()
	}
}

// MARK: Private methods

private extension ViewController {
	func initialLocation() {
		// Set initial location in Honolulu
		let initialLocation = CLLocation(
			latitude: 21.282778,
			longitude: -157.829444
		)
		mapView.centerToLocation(initialLocation)
	}
	
	func loadInitialData() {
		
		guard let fileName = Bundle.main.url(
			forResource: "PublicArt",
			withExtension: "geojson"
		),
			  let artworkData = try? Data(contentsOf: fileName) else {
			return
		}
		
		do {
			let features = try MKGeoJSONDecoder()
				.decode(artworkData)
				.compactMap { $0 as? MKGeoJSONFeature }
			let validWorks = features.compactMap(Artwork.init)
			artworks.append(contentsOf: validWorks)
		} catch {
			print("Unexpected error: \(error).")
		}
	}
	
	func configureMapView() {
		let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
		let region = MKCoordinateRegion(
			center: oahuCenter.coordinate,
			latitudinalMeters: 50000,
			longitudinalMeters: 60000
		)
		mapView.setCameraBoundary(
			MKMapView.CameraBoundary(coordinateRegion: region),
			animated: true
		)
		
		let zoomRage = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200_000)
		mapView.setCameraZoomRange(zoomRage, animated: true)
	}
}

// MARK: - MKMapViewDelegate

extension ViewController: MKMapViewDelegate {
	func mapView(
		_ mapView: MKMapView,
		annotationView view: MKAnnotationView,
		calloutAccessoryControlTapped control: UIControl
	) {
		
		guard let artwork = view.annotation as? Artwork else {
			return
		}
		
		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
		artwork.mapItem?.openInMaps(launchOptions: launchOptions)
	}
}
