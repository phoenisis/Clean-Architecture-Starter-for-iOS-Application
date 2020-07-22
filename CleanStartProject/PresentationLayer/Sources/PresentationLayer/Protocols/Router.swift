//
//  Router.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 16/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import UIKit

public protocol Router {
	func route(
		to routeID	: String,
		parameters	: Any?
	)
}
