//
//  PostDetailTableViewController.swift
//  CleanStartProject
//
//  Created by Quentin PIDOUX on 16/05/2020.
//  Copyright © 2020 Quentin PIDOUX. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
	public var postID: Int?

	private var stateViewModel: PostDetailStateViewModel?

	var state: PostDetailStateViewModel.State = PostDetailStateViewModel.State() {
		didSet {
			self.tableView.reloadData()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		guard let postID = postID else {
			self.navigationController?.popViewController(animated: true)
			return
		}

		self.stateViewModel = PostDetailStateViewModel(view: self)
		self.stateViewModel?.getPostById(id: postID)

		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return state.comments.isEmpty ? 1 : 2
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
			case 0:
				return "Post"
			case 1:
				return "Comments"
			default:
			return nil
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		switch section {
			case 0:
				return 1
			case 1:
				return state.comments.count
			default:
				return 0
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .default, reuseIdentifier: "\(indexPath)")
		cell.textLabel?.numberOfLines = 0
		cell.selectionStyle = .none

		if indexPath.section == 0 {
			if state.loading {
				cell.textLabel?.text = "Loading"
			} else if let empty = state.empty {
				cell.textLabel?.text = empty
			} else if let error = state.error {
				cell.textLabel?.text = error
			} else {
				cell.textLabel?.text = state.post?.title
			}
		} else {
			if let comment = state.comments.item(at: indexPath.row) {
				cell.textLabel?.text = comment.body
			}
		}

		return cell
	}

	/*
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
	
	// Configure the cell...
	
	return cell
	}
	*/

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

}

extension PostDetailTableViewController: PostDetailViewProtocol {
	func viewUpdateWith(state: PostDetailStateViewModel.State) {
		self.state = state
	}
}
