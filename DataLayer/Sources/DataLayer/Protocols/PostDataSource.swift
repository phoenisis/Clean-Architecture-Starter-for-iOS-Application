//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 17/05/2020.
//

import Foundation
import RxSwift

public protocol PostDataSource {

	func getAll() -> Observable<[PostData]>

	func getPost(id: Int) -> Observable<PostData>
}
