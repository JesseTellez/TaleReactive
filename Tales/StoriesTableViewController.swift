//
//  StoriesTableViewController.swift
//  Tales
//
//  Created by Jesse Tellez on 1/22/17.
//  Copyright © 2017 Tales. All rights reserved.
//
import Prelude
import ReactiveSwift
import UIKit

class StoriesTableViewController: UITableViewController {
    
    
    fileprivate let viewModel: StoriesViewModelType = StoriesViewModel()
    fileprivate let dataSource = StoriesDataSource()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = dataSource
        self.viewModel.inputs.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal override func bindViewModel() {
        super.bindViewModel()
        
        //Grab the stories from the storiesViewModel (Queries all of them)
        //Then give them to the StoriesDataSource
        self.viewModel.outputs.stories
            .observeForUI()
            .observeValues { [weak self] stories in
                self?.dataSource.load(stories: stories)
                self?.tableView.reloadData()
        }
    }
    
    internal override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? StoriesFeedCell {
            
        }
        
        self.viewModel.inputs.willDisplayRow(indexPath.row, outOf: self.dataSource.numberOfItems())
    }
    

}
