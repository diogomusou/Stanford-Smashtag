//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Diogo M Souza on 2017/07/16.
//  Copyright © 2017 Diogo M Souza. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetProfileImage: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUsernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet : Twitter.Tweet? { didSet { updateUI() }}
    
    private func updateUI() {
        tweetTextLabel?.text = tweet?.text
        tweetUsernameLabel?.text = tweet?.user.description
//        print("tweet text: \(tweet?.text ?? "")")
        
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24 * 60 * 60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from: created)
        } else {
            tweetCreatedLabel?.text = nil
        }
        
        tweetProfileImage?.image = nil
        if let profileImageURL = tweet?.user.profileImageURL {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    DispatchQueue.main.async {
                        self?.tweetProfileImage?.image = UIImage(data: imageData)
                    }
                }
            }
        } else {
            tweetProfileImage?.image = nil
        }
    }
    

}
