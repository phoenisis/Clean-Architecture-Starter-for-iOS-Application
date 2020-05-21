//
//  File.swift
//  
//
//  Created by Quentin PIDOUX on 21/05/2020.
//

import Foundation

public struct PostDetailState {
	public var loading : Bool
	public var post    : Post?
	public var comments: [Comment]
	public var empty   : String?
	public var error   : String?
	public var cancel  : Bool

	public init() {
		self.loading  = false
		self.post     = nil
		self.comments = []
		self.empty    = nil
		self.error    = nil
		self.cancel   = false
	}
}
