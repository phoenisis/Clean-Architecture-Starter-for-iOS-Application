//
//  PostsTableViewController.swift
//  RemoteLayer
//
//  Created by Quentin PIDOUX on 15/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {
	private var stateViewModel: PostsStateViewModel?

	private var state: PostsStateViewModel.State = PostsStateViewModel.State() {
		didSet {
			self.tableView.reloadData()
			self.tableView.refreshControl?.endRefreshing()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		stateViewModel = PostsStateViewModel(view: self, router: PostsRouter(context: self))

		stateViewModel?.getAll()

		self.title = "Posts"

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if state.loading || state.empty != nil || state.error != nil {
			return 1
		}

		return state.posts.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "\(indexPath)")
		cell.textLabel?.numberOfLines = 0

		if state.loading {
			cell.textLabel?.text = "Loading"
		} else if let empty = state.empty {
			cell.textLabel?.text = empty
		} else if let error = state.error {
			cell.textLabel?.text = error
		} else {
			if let post = state.posts.item(at: indexPath.row) {
				cell.textLabel?.text = post.title
			}
		}

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let post = state.posts.item(at: indexPath.row) {
			self.stateViewModel?.showPostId(post.id)
		}
	}

	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/

	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/

	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/

	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/

	@IBAction
	private func reloadData(_ sender: Any) {
		self.stateViewModel?.getAll()
	}
}

extension PostsTableViewController: PostsViewProtocol {
	func viewUpdateWith(state: PostsStateViewModel.State) {
		self.state = state
	}
}
