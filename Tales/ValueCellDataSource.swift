//
//  ValueCellDataSource.swift
//  Tales
//
//  Created by Jesse Tellez on 1/21/17.
//  Copyright © 2017 Tales. All rights reserved.
//

import Foundation
import UIKit

open class ValueCellDataSource: NSObject, UICollectionViewDataSource, UITableViewDataSource {
    
    
    private var values: [(value: Any, reusableId: String)] = []
    
    open func configureCell(collectionCell cell: UICollectionViewCell, withValue value: Any) {
    }
    
    open func configureCell(tableCell cell: UITableViewCell, withValue value: Any){
    }
    
    public final func clearValues() {
        self.values = []
    }
    
    public final func appendRow<Cell: ValueCell, Value: Any>(value: Value, cellClass: Cell.Type) where Cell.Value == Value {
        self.values.append((value, Cell.defaultReusableId))
    }
    
    private func padValuesForSection(_ section: Int) {
        guard self.values.count <= section else {return}
        
    }
    
    public final func numberOfItems() -> Int {
        
        return self.values.count
        
    }
    
    
    public final func collectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let (value, reusableId) = self.values[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath)
        
        self.configureCell(collectionCell: cell, withValue: value)
        
        return cell
    }
    
    public final func collectionView(_ collectionView: UICollectionView,
                                     numberOfItemsInSection section: Int) -> Int {
        return self.values.count
    }
    
    public final func tableView(_ tableView: UITableView,
                                cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let (value, reusableId) = self.values[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath)
        
        self.configureCell(tableCell: cell, withValue: value)
        
        return cell
    }
    
    public final func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    public final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }
    
}
