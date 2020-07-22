//
//  RouteManager.swift
//  
//
//  Created by Quentin PIDOUX on 15/05/2020.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import PLogger
import Common

class RemoteManager {
	private func request(_ request: URLRequestConvertible, isAuthRoute: Bool = true) -> Observable<Bool> {
		return RxAlamofire.request(request)
			.validate(statusCode: 200..<400)
			.responseJSON()
			.flatMap({ (response) -> Observable<Bool> in
				switch response.result {
					case .success:
						return Observable.just(true)
					default:
						return Observable.just(false)
				}
			})
			.do(onError: { (error) in
				self.doOnError(error: error, isAuthRoute: isAuthRoute)
				throw error.localizedDescription
			})
	}

	private func request<T>(_ type: T.Type, _ request: URLRequestConvertible, isAuthRoute: Bool = true) -> Observable<T> where T: Decodable {
		return RxAlamofire.request(request)
			.responseData()
			.map { response in
				return try self.customDecoder(T.self, from: response.1)
		}
		.do(onError: { (error) in
			self.doOnError(error: error, isAuthRoute: isAuthRoute)
		})
	}

	private func requestData(_ request: URLRequestConvertible, isAuthRoute: Bool = true) -> Observable<Foundation.Data> {
		return RxAlamofire.request(request)
			.validate(statusCode: 200..<400)
			.responseData()
			.map({ response in
				return response.1
			})
			.do(onError: { (error) in
				self.doOnError(error: error, isAuthRoute: isAuthRoute)
			})
	}

	private func doOnError(error: Error, isAuthRoute: Bool) {
		#if DEBUG
		PLogger.error(error)
		#endif
	}

	private func customDecoder<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
		let decoder = JSONDecoder()

		decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
			let container = try decoder.singleValueContainer()
			let dateStr   = try container.decode(String.self)

			guard let date = Date(iso8601String: dateStr) else {
				throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
			}
			return date
		})

		return try decoder.decode(type, from: data)
	}
}

// MARK: - POST requests
extension RemoteManager {

	//    private func post<T>(_ type: T.Type, _ request: URLRequestConvertible) -> Observable<T> where T : Decodable {
	//        return RxAlamofire.request(.post, request)
	//            .validate(statusCode: 200..<400)
	//            .responseData()
	//            .map { response in
	//                try self.customDecoder(T.self, from: response.1)
	//        }
	//    }
}

// MARK: - Timeline
extension RemoteManager {
	func getAllPosts() -> Observable<[PostRemote]> {
		return request([PostRemote].self, RemoteRouter.getAllPosts)
	}

	func getPost(id: Int) -> Observable<PostRemote> {
		return request(PostRemote.self, RemoteRouter.getPost(id: id))
	}

	func getAllComments() -> Observable<[CommentRemote]> {
		return request([CommentRemote].self, RemoteRouter.getAllComments)
	}

	func getCommentsFromPost(id: Int) -> Observable<[CommentRemote]> {
		return request([CommentRemote].self, RemoteRouter.getCommentsFromPost(id: id))
	}
}
