import Foundation
import UIKit

/**
 A type-safe wrapper around a two-dimensional array of values that can be used to provide a data source for
 `UICollectionView`s and `UITableView`s. There is no direct access to the two-dimensional array, and instead
 values can be appended via public methods that make sure the value you are add to the data source matches
 the type of value the table/collection cell can handle.
 */
open class ValueCellDataSource: NSObject, UICollectionViewDataSource, UITableViewDataSource {
    
    private var values: [(value: Any, reusableId: String)] = []
    
    /**
     Override this method to destructure `cell` and `value` in order to call the `configureWith(value:)` method
     on the cell with the value. This method is called by the internals of `ValueCellDataSource`, it does not
     need to be called directly.
     
     - parameter cell:  A cell that is about to be displayed.
     - parameter value: A value that is associated with the cell.
     */
    open func configureCell(collectionCell cell: UICollectionViewCell, withValue value: Any) {
    }
    
    /**
     Override this method to destructure `cell` and `value` in order to call the `configureWith(value:)` method
     on the cell with the value. This method is called by the internals of `ValueCellDataSource`, it does not
     need to be called directly.
     
     - parameter cell:  A cell that is about to be displayed.
     - parameter value: A value that is associated with the cell.
     */
    open func configureCell(tableCell cell: UITableViewCell, withValue value: Any) {
    }
    
    /**
     Override this to perform any registrations of cell classes and nibs. Call this method from your controller
     before the data source is set on the collection view. If you are using prototype cells you do not need
     to call this.
     
     - parameter collectionView: A collection view that needs to have cells registered.
     */
    open func registerClasses(collectionView: UICollectionView?) {
    }
    
    /**
     Override this to perform any registrations of cell classes and nibs. Call this method from your controller
     before the data source is set on the table view. If you are using prototype cells you do not need
     to call this.
     
     - parameter tableView: A table view that needs to have cells registered.
     */
    open func registerClasses(tableView: UITableView?) {
    }
    
    /**
     Removes all values from the data source.
     */
    public final func clearValues() {
        self.values = []
    }
    
    
    /**
     Adds a single value to the end of the section specified.
     
     - parameter value:     A value to append.
     - parameter cellClass: The type of cell associated with the value.
     - parameter section:   The section to append the value to.
     */
    public final func appendRow <
        Cell: ValueCell,
        Value: Any>
        (value: Value, cellClass: Cell.Type)
        where
        Cell.Value == Value {
            
            self.values.append((value, Cell.defaultReusableId))
    }
    

    
    /**
     Replaces a row with a value.
     
     - parameter value:     A value to replace the row with.
     - parameter cellClass: The type of cell associated with the value.
     - parameter section:   The section for the row.
     - parameter row:       The row to replace.
     */
    public final func set <
        Cell: ValueCell,
        Value: Any>
        (value: Value, cellClass: Cell.Type, row: Int)
        where
        Cell.Value == Value {
            
            self.values[row] = (value, Cell.defaultReusableId)
    }
    
    /**
     - parameter indexPath: An index path to retrieve a value.
     
     - returns: The value at the index path given.
     */
    public final subscript(indexPath: IndexPath) -> Any {
        return self.values[indexPath.item].value
    }
    
    /**
     - returns: The total number of items in the data source.
     */
    public final func numberOfItems() -> Int {
        return self.values.count
    }
    
    
    
    public final func collectionView(_ collectionView: UICollectionView,
                                     numberOfItemsInSection section: Int) -> Int {
        return self.values.count
    }
    
    public final func collectionView(_ collectionView: UICollectionView,
                                     cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let (value, reusableId) = self.values[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath)
        
        self.configureCell(collectionCell: cell, withValue: value)
        
        return cell
    }
    
    // MARK: UITableViewDataSource methods
    
    public final func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }
    
    public final func tableView(_ tableView: UITableView,
                                cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let (value, reusableId) = self.values[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath)
        
        self.configureCell(tableCell: cell, withValue: value)
        
        return cell
    }
}
