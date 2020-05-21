//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 21/05/2020.
//

import Foundation

public struct PostState {
	public var loading: Bool
	public var posts  : [Post]
	public var empty  : String?
	public var error  : String?
	public var cancel : Bool

	public init() {
		self.loading = false
		self.posts   = []
		self.empty   = nil
		self.error   = nil
		self.cancel  = false
	}
}
