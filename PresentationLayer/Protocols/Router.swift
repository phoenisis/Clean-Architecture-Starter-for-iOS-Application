//
//  Router.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 16/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
	associatedtype Route

	func route(
		to routeID	: Route,
		parameters	: Any?
	)
}
