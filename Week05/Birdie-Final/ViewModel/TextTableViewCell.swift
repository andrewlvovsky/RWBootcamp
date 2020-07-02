//
//  TextTableViewCell.swift
//  Birdie-Final
//
//  Created by Andrew Lvovsky on 7/1/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

  @IBOutlet weak var username: UILabel!
  @IBOutlet weak var timestamp: UILabel!
  @IBOutlet weak var body: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
