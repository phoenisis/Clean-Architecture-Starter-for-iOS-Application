//
//  PostsRouter.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 16/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation
import PresentationLayer
import UIKit

open class PostsRouter: Router {
	unowned private var context: UIViewController

	public init(context: UIViewController) {
		self.context = context
	}

	public func route(to routeID: String, parameters: Any?) {
		switch routeID {
			case "detail":
				guard let view = R.storyboard.main.postDetail() else {
					break
				}
				if let postID = parameters as? Int {
					view.postID = postID
				}

				context.navigationController?.pushViewController(view, animated: true)
			default:
				break
		}
	}
}
