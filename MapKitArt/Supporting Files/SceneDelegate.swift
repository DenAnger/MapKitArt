//
//  SceneDelegate.swift
//  MapKit
//
//  Created by Denis Abramov on 24.05.2020.
//  Copyright © 2020 Denis Abramov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let _ = (scene as? UIWindowScene) else { return }
	}
}
