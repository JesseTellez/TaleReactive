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

internal final class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var reactiveButton: UIButton!
    @IBOutlet weak var storiesTableView: UITableView!
    fileprivate let viewModel: StoriesViewModelType = StoriesViewModel()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func bindViewModel() {
        self.viewModel.outputs.stories
            .observeForUI()
            .observeValues { [weak self] activities in
                self?.dataSource.load(activities: activities)
                self?.tableView.reloadData()
        }
        
    }

}
