//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate {
    
    var businesses: [Business]! = []
    var resultsPageOffset = 0
    var isDataLoading = false
    var isMoreDataLoading = false
    var allDistancesInMeters:[Double]!
    
    var currentCategorySwitchStates = [Int:Bool]()
    var searchBar: UISearchBar!
    
    var currentFilters = (
        sortMode: "Best Match",
        sortRowIndex:0,
        isDealON: false,
        distance: "Auto",
        distanceRowIndex:0
    )
    
    @IBOutlet weak var businessTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = UIColor.red

        allDistancesInMeters = [0, 0.3 * 1609.34, 1609.34, 5 * 1609.34 , 20 * 1609.34]

        searchBar = UISearchBar()
        navigationItem.titleView = searchBar
        
        searchBar.sizeToFit()
        
        businessTableView.delegate=self
        businessTableView.dataSource=self
        
        searchBar.delegate=self
        //layout using autolayout rules
       businessTableView.rowHeight=UITableViewAutomaticDimension
        //used for scroll height dimension
       businessTableView.estimatedRowHeight = 120
        
    
        
        getBusinessess(searchText: "", distance: nil, sort: nil, categories: nil, deals: nil)

        
    }
    
      var lastSearchParams = (term: "", distance: 0.0, sort: YelpSortMode.bestMatched, cats: [String](), isDealOn: false)
    
    func getBusinessess(searchText: String, distance: Double?, sort: YelpSortMode?, categories: [String]?, deals: Bool?){
        lastSearchParams.term = searchText
        lastSearchParams.distance = distance ?? 0
        lastSearchParams.sort = sort ?? YelpSortMode.bestMatched
        lastSearchParams.cats = categories ?? []
        lastSearchParams.isDealOn = deals ?? false
        
        Business.searchWithTerm(term: searchText, offset: resultsPageOffset, distance: distance, sort: sort, categories: categories, deals: deals, completion: { (businesses: [Business]?, error: Error?) -> Void in
            if(error != nil) {
               
                
                
            }
            else {
                
              self.businesses = businesses
              self.businessTableView.reloadData()
                }
                
            })
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController {
            if let filtersViewController = navController.topViewController as? FiltersViewController{
                filtersViewController.delegate = self
                filtersViewController.currentFilters = currentFilters
                filtersViewController.switchStates = currentCategorySwitchStates
            }
            
            else if let mapsController = navController.topViewController as? MapsController
            
            {
                mapsController.businesses = businesses
            }
          
        }
        
    }
 
    
    /*
   func filtersViewController(filtersViewConrtoller:FiltersViewController,
                               didUpdateFilters filters:[String:AnyObject]){
        var categories = filters["categories"] as? [String]
        Business.searchWithTerm(term: "Restaurants", sort:nil, categories: categories, deals: nil) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.businessTableView.reloadData()
        }
    
  } */
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultsPageOffset=0
        if searchText.isEmpty {
            searchBar.text = nil
            searchBar.setShowsCancelButton(false, animated: true)
            
            // Remove focus from the search bar.
            searchBar.endEditing(true)
            getBusinessess (searchText: "", distance: nil, sort: nil, categories: nil, deals: nil)
          
            
        } else {
            getBusinessess(searchText: searchText, distance: nil, sort: nil, categories: nil, deals: nil)
        }
    }
 
}


extension BusinessesViewController:FiltersViewControllerDelegate{
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        let categories = filters["categories"] as? [String]
        let isDealON = filters["deal"] as? Bool
      

        
        let distanceRow = filters["distanceRowIndex"] as? Int
        let distance = filters["distance"] as? String
        
        let sortByRowIndex = filters["sortByRowIndex"] as? Int
        let sortyBy = filters["sortBy"] as? String
        
        var sortByMode = YelpSortMode.bestMatched
        if(sortyBy == "Best Match"){
            sortByMode = YelpSortMode.bestMatched
        }
        else if(sortyBy == "Distance"){
            sortByMode = YelpSortMode.distance
        }
        else if(sortyBy == "Rating"){
            sortByMode = YelpSortMode.highestRated
        }
        
        
        
        //update filters used to pass it to filter view
       currentFilters.sortMode = sortyBy!
       currentFilters.sortRowIndex = sortByRowIndex!
       currentFilters.distanceRowIndex = distanceRow!
       currentFilters.distance = distance!
       currentFilters.isDealON = isDealON!
        
        if(filters["switchStates"] as? [Int:Bool] != nil){
             currentCategorySwitchStates = filters["switchStates"] as! [Int : Bool]
        }
        
        resultsPageOffset = 0
        getBusinessess(searchText: "", distance: allDistancesInMeters[distanceRow!], sort: sortByMode, categories: categories, deals: isDealON)
    }
}
extension BusinessesViewController:UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if businesses != nil {
        return businesses.count
        }else
        {
            return 0;
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses![indexPath.row]
        
        return cell
    }
}




    

