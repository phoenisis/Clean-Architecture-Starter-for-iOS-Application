//
//  PostsRouter.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 16/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import UIKit

class PostsRouter: Router {
	unowned private var context: UIViewController
	typealias Route = PostsRoute

	enum PostsRoute: String {
		case detail
	}

	init(context: UIViewController) {
		self.context = context
	}

	func route(to routeID: Route, parameters: Any?) {

		switch routeID {
			case .detail:
				guard let view = R.storyboard.main.postDetail() else {
					break
				}
				if let postID = parameters as? Int {
					view.postID = postID
				}

				context.navigationController?.pushViewController(view, animated: true)
		}
	}
}
