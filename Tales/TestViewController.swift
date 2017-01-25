//
//  TestViewController.swift
//  Tales
//
//  Created by Jesse on 1/17/17.
//  Copyright © 2017 Tales. All rights reserved.
//
import Prelude
import ReactiveSwift
import UIKit

internal final class TestViewController: UIViewController {

    @IBOutlet weak var reactiveButton: UIButton!
    @IBOutlet weak var storiesTableView: UITableView!
    fileprivate let viewModel: StoriesViewModelType = StoriesViewModel()
    fileprivate let dataSource = StoriesDataSource()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.storiesTableView.dataSource = dataSource
        self.viewModel.inputs.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal override func bindViewModel() {
        super.bindViewModel()
        
        //Grab the stories from the storiesViewModel (Queries all of them)
        //Then give them to the StoriesDataSource
        self.viewModel.outputs.stories
            .observeForUI()
            .observeValues { [weak self] stories in
                self?.dataSource.load(stories: stories)
                self?.storiesTableView.reloadData()
        }
    }
    
    //this might not work because what would ever call it if its just a basic view controller?
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? StoriesFeedCell {
        
        }
        
        self.viewModel.inputs.willDisplayRow(indexPath.row, outOf: self.dataSource.numberOfItems())
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

extension TestViewController: StoryFeedCellDelegate {
    
}
