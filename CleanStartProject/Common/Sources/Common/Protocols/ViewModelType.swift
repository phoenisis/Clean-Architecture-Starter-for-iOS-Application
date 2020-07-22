//
//  ViewModelType.swift
//  
//
//  Created by Quentin PIDOUX on 15/05/2020.
//

import Foundation

extension String: Error {}

public protocol ViewModelType {
	associatedtype Input
	associatedtype Output

	func transform(input: Input) -> Output
}
