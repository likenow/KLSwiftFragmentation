//
//  KLCommentCell.swift
//  KLSwift
//
//  Created by kai lee on 16/11/7.
//  Copyright © 2016年 kai lee. All rights reserved.
//

import UIKit
import Kingfisher

//protocol KLCommentCellDelegate: class {
//    func commentCelll(_ cell: KLCommentCell, type: Int)
//}

class KLCommentCell: UITableViewCell {
    // MARK: - 控件属性
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var expandBtn: UIButton!
    @IBOutlet weak var replyLabel: UILabel!
    
    fileprivate var isAnimatting: Bool = false
    
    // MARK: - 模型属性
    var comment: KLCommentModel? {
        didSet {
            guard let comment = comment else { return }
            guard let avatarUrl = URL(string: comment.avatar) else { return }
            avatar.kf.setImage(with: avatarUrl)
            
            nameLabel.text = comment.author
            
            commentLabel.text = comment.content
            
            guard let reply_to = comment.reply_to else {
                return
            }
            let replyStr = "//"+"\(reply_to.author)"
            let length = replyStr.characters.count
            let nameAttr = NSMutableAttributedString(string: replyStr)
            nameAttr.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSMakeRange(0, length))

            let contentStr = "\(reply_to.content)"
            let len = contentStr.characters.count
            let contentAttr = NSMutableAttributedString(string: contentStr)
            contentAttr.addAttribute(NSForegroundColorAttributeName, value: UIColor(89, 89, 89), range: NSMakeRange(0, len))
            
            nameAttr.append(contentAttr)
            
            replyLabel.attributedText = nameAttr;
            expandBtn.isHidden = false
            
            likeLabel.text = "\(comment.likes)"
            
            if comment.isLike! {
                likeImage.image = UIImage(named: "Comment_Voted")
                likeLabel.textColor = UIColor(48, 127, 255)
            } else {
                likeImage.image = UIImage(named: "Comment_Vote")
                likeLabel.textColor = UIColor(128, 128, 128)
            }

            replyLabel.numberOfLines = comment.isOpen! ? 0 : 2
            expandBtn.isSelected = comment.isOpen!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd HH:mm"
            dateFormatter.date(from: Date.getCurrentTime())
            
            timeLabel.text = "\(dateFormatter.date(from: Date.getCurrentTime()))"
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatar.layer.cornerRadius = 20
        avatar.layer.masksToBounds = true
        expandBtn.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
