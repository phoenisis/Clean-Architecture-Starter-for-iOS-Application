//
//  Router.swift
//  
//
//  Created by Quentin PIDOUX on 15/05/2020.
//

import Foundation
import Alamofire
import SwifterSwift
import Common
import UIKit

/// RemoteRouter
///
/// Routes availables
/// - me
/// - planning
/// - activity    - Parameter id (Int)
/// - menu      - Parameter id (Int)
/// - menus      - Parameter ids ([Int])
/// - exercise    - Parameter id (String)
/// - outdoorMeal  - Parameter id (Int)
///
/// Model based on:
/// [Github Reference](https://github.com/AladinWay/NetworkingExample)

enum HTTPHeaderField: String {
	case authentication = "Authorization"
	case contentType    = "Content-Type"
	case acceptType     = "Accept"
	case acceptEncoding = "Accept-Encoding"
	case userAgent      = "User-Agent"
	case acceptLanguage = "Accept-Language"
}

enum ContentType: String {
	case json = "application/json"
}

enum RemoteRouter: URLRequestConvertible {

	case getAllPosts
	case getPost(id: Int)
	case getAllComments
	case getCommentsFromPost(id: Int)

	// MARK: - HTTPMethod
	private var method: HTTPMethod {
		switch self {
			//			case .register:
			//				return .post
			//			case .patchFreeSportSession:
			//				return .patch
			//			case .saveActivityDish:
			//				return .put
			//			case .deleteFreeSportSession:
			//				return .delete
			default:
				return .get
		}
	}

	// MARK: - Path
	private var path: String {
		switch self {
			case .getAllPosts:
				return "/posts"
			case .getPost(let id):
				return "/posts/\(id)"
			case .getAllComments:
				return "/comments"
			case .getCommentsFromPost(let id):
				return "/posts/\(id)/comments"
		}
	}

	// MARK: - Parameters
	private var parameters: Parameters? {
		switch self {
			//			case .menus(let ids):
			//				return ["id": ids.map { String($0) }.joined(separator: ","), "limit": 50]
			//				return nil
			default:
				return nil
		}
	}

	// MARK: - Body
	private func getBody() throws -> Data? {
		switch self {
			//			case .login(let body):
			//				return try JSONEncoder().encode(body)
			default:
				return nil
		}
	}

	private var getCachePolicy: URLRequest.CachePolicy {
		switch self {
			case .getAllPosts:
				return .reloadIgnoringLocalCacheData
			default:
				return .useProtocolCachePolicy
		}
	}

	private var isAuthRoute: Bool {
		switch self {
			case .getAllPosts:
				return false
			default:
				return true
		}
	}

	private var environement: String {
		switch UIApplication.shared.inferredEnvironment {
			case .debug:
				return "DEBUG"
			case .testFlight:
				return "Testflight"
			case .appStore:
				return "AppStore"
		}
	}

	private var userAgent: String {
		return "iOS/\(UIDevice.current.systemVersion) (type \(UIDevice.current.model); Environment \(environement)"
	}

	var url: URL? {
		switch self {
			default:
				return "https://jsonplaceholder.typicode.com".url
		}
	}

	// MARK: - URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		guard let url = url else {
			throw "invalid request URL"
		}
		var urlRequest = URLRequest(url: url.appendingPathComponent(path))

		/// HTTP Method
		urlRequest.httpMethod = method.rawValue
		/// Cache policy
		urlRequest.cachePolicy = getCachePolicy

		if isAuthRoute {
			/// Common Headers
			//			if let token = Default().accessToken {
			//				urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
			//			}
		}

		/// User agent
		urlRequest.setValue(userAgent, forHTTPHeaderField: HTTPHeaderField.userAgent.rawValue)

		/// Headers
		urlRequest.setValue(Locale.current.languageCode, forHTTPHeaderField: HTTPHeaderField.acceptLanguage.rawValue)
		urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
		urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

		urlRequest.httpBody = try getBody()

		return try URLEncoding.default.encode(urlRequest, with: parameters)
	}
}
