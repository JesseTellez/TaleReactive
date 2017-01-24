//
//  StoriesFeedCell.swift
//  Tales
//
//  Created by Jesse Tellez on 1/22/17.
//  Copyright © 2017 Tales. All rights reserved.
//
import Prelude
import UIKit
import ReactiveSwift

internal protocol StoryFeedCellDelegate {
    
    //If you are going to be the delegate of this cell - you must implement this
    //ex: StoryFeedCellTappedImage()....do something
    
}

internal final class StoriesFeedCell: UITableViewCell, ValueCell {
    
    fileprivate var viewModel: StoryViewModelType = StoryViewModel()
    
    @IBOutlet fileprivate weak var storyTitleLabel: UILabel!
    
    @IBOutlet fileprivate weak var storyBookmarksLabel: UILabel!
    
    @IBOutlet fileprivate weak var storyIdLabel: UILabel!
    
    //static var defaultReusableId: String

    internal func configureWith(value: Story) {
        self.viewModel.inputs.configureWith(story: value)
    }
    
    internal override func bindViewModel() {
        super.bindViewModel()
        self.storyTitleLabel.rac.text = self.viewModel.outputs.storyTitleLabel
        self.storyBookmarksLabel.rac.text = self.viewModel.outputs.storyBookmarkLabel
        self.storyIdLabel.rac.text = self.viewModel.outputs.storyIdLabel
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
