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
    //tableview.delegate = self
    tableview.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextPostCellView")
    tableview.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImagePostCellView")
    tableview.dataSource = self
    MediaPostsHandler.shared.getPosts()
  }

  @IBAction func didPressCreateTextPostButton(_ sender: Any) {
    let alert = UIAlertController(title: "Add Post", message: nil, preferredStyle: .alert)
    alert.addTextField(configurationHandler: nil)
    alert.addTextField(configurationHandler: nil)
    alert.textFields![0].autocapitalizationType = .sentences
    alert.textFields![0].placeholder = "Username"
    alert.textFields![1].autocapitalizationType = .sentences
    alert.textFields![1].placeholder = "Message"
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
      let newRowIndex = MediaPostsHandler.shared.mediaPosts.count
      let newTextPost = TextPost(textBody: alert.textFields![1].text!, userName: alert.textFields![0].text!, timestamp: Date())
      MediaPostsHandler.shared.addTextPost(textPost: newTextPost)
      let indexPath = IndexPath(row: newRowIndex, section: 0)
      let indexPaths = [indexPath]
      self.tableview.insertRows(at: indexPaths, with: .automatic)
      self.tableview.reloadData()
    })

    alert.addAction(action)

    present(alert, animated: true, completion: nil)
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
      cell = tableView.dequeueReusableCell(withIdentifier: "TextPostCellView", for: indexPath)
      configureText(for: cell, with: post as! TextPost)
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "ImagePostCellView", for: indexPath)
      configureImage(for: cell as! ImageTableViewCell, with: post as! ImagePost)
    }
    return cell
  }

  func configureText(for cell: UITableViewCell, with post: TextPost) {
    if let textCell = cell as? TextTableViewCell {
      textCell.username.text = post.userName
      textCell.timestamp.text = returnDateAsString(for: post.timestamp)
      textCell.body.text = post.textBody
    }
  }

  func configureImage(for cell: ImageTableViewCell, with post: ImagePost) {
    cell.username.text = post.userName
    cell.timestamp.text = returnDateAsString(for: post.timestamp)
    cell.body.text = post.textBody
    cell.postImage.image = post.image
  }

  func returnDateAsString(for date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM'T'HH:mm")
    return dateFormatter.string(from: date)
  }

}



