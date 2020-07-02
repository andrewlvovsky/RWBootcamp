//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableview: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
  }

  func setUpTableView() {
    // Set delegates, register custom cells, set up datasource, etc.
    tableview.delegate = self
    tableview.dataSource = self
    MediaPostsHandler.shared.getPosts()
  }

  @IBAction func didPressCreateTextPostButton(_ sender: Any) {
  }

  @IBAction func didPressCreateImagePostButton(_ sender: Any) {

  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MediaPostsHandler.shared.mediaPosts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let post = MediaPostsHandler.shared.mediaPosts[indexPath.row]
    let cell: UITableViewCell
    if post is TextPost {
      cell = tableView.dequeueReusableCell(withIdentifier: "TextPost", for: indexPath)
      configureText(for: cell, with: post as! TextPost)
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "ImagePost", for: indexPath)
      configureImage(for: cell, with: post as! ImagePost)
    }
    return cell
  }

  func configureText(for cell: UITableViewCell, with post: TextPost) {
    let textCell = cell as? TextTableViewCell
    textCell?.username.text = post.userName
    textCell?.timestamp.text = post.timestamp.description
    textCell?.body.text = post.textBody
  }

  func configureImage(for cell: UITableViewCell, with post: ImagePost) {
    if let imageCell = cell as? ImageTableViewCell {
      imageCell.username.text = post.userName
      imageCell.timestamp.text = post.timestamp.description
      imageCell.body.text = post.textBody
      imageCell.postImage = UIImageView(image: post.image)
    }
  }

}



