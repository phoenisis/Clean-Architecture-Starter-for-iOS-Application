//
//  Array+extensions.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 15/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import Foundation

extension Array {
	public func item(at index: Int) -> Element? {
		guard startIndex..<endIndex ~= index else { return nil }
		return self[index]
	}
}
