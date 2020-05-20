//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 18/05/2020.
//

import Foundation
import RxSwift

public protocol PostsRepositorySource {

	func getAllPosts() -> Observable<[PostDomain]>

	func getPost(id: Int) -> Observable<PostDomain>
}
