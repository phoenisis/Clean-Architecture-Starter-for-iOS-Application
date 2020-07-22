//
//  PostSource.swift
//  
//
//  Created by Quentin PIDOUX on 15/05/2020.
//

import Foundation
import RxSwift
import DataLayer

open class PostSource: PostDataSource {
	public init() {}

	public func getAll() -> Observable<[DataLayer.PostData]> {
		return RemoteManager().getAllPosts()
			.map { (input) -> [DataLayer.PostData] in
				PostRemoteMapper().transform(input: input)
		}
	}

	public func getPost(id: Int) -> Observable<DataLayer.PostData> {
		return RemoteManager().getPost(id: id)
			.map { (input) -> DataLayer.PostData in
				PostRemoteMapper().transform(input: input)
		}
	}
}
