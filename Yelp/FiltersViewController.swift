  //
//  FiltersViewController.swift
//  Yelp
//
//  Created by Yerneni, Naresh on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
  
  @objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject])
  }

class FiltersViewController: UIViewController {

    
  
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:FiltersViewControllerDelegate?
     
    var categories:[[String:String]]!
    var switchStates = [Int:Bool]()
    
    var distanceState = (rowSelected:0,rowSelectedLabel: "Auto")
    var sortByState = (rowSelected:0,rowSelectedLabel: "Best Match")
    var isDealOnState = [Int:Bool]()
    var catSwitchStates:[Int:Bool]!
     var allDistances:[String]!
      var allSortByOptions:[String]!
    
    let doneImage = UIImage(named: "done")
    let notDoneImage = UIImage(named: "oval")

    var distanceExpanded = false
    var sortByExpanded = false
    var categoryExpanded = false
    
    var currentFilters:(sortMode: String, sortRowIndex: Int, isDealON: Bool, distance: String, distanceRowIndex: Int)!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        
      

        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 45
        
         categories=yelpCategories()
        allDistances = ["Auto","0.3 miles", "1 mile","5 mile","20 miles"]
        
        allSortByOptions = ["Best Match","Distance","Rating", "Most Reviewed"]
        
        
        if(currentFilters != nil){
            distanceState.rowSelected = currentFilters.distanceRowIndex
            distanceState.rowSelectedLabel = currentFilters.distance
            
            sortByState.rowSelectedLabel = currentFilters.sortMode
            sortByState.rowSelected = currentFilters.sortRowIndex
            
            isDealOnState = [0: currentFilters.isDealON]
            catSwitchStates=switchStates
        }

        let dealNib = UINib(nibName: "Deal", bundle: nil)
        tableView.register(dealNib, forCellReuseIdentifier: "Deal")
        
        let selectedCellNib = UINib(nibName: "SelectedDropdownCell", bundle: nil)
        tableView.register(selectedCellNib, forCellReuseIdentifier: "SelectedDropdownCell")
        
        let distanceSwitchNib = UINib(nibName: "Distance", bundle: nil)
        tableView.register(distanceSwitchNib, forCellReuseIdentifier: "Distance")
        
        let sortBySwitchNib = UINib(nibName: "SortByCell", bundle: nil)
        tableView.register(sortBySwitchNib, forCellReuseIdentifier: "SortByCell")
        
        
        let categorySwitchNib = UINib(nibName: "SwitchCell", bundle: nil)
        tableView.register(categorySwitchNib, forCellReuseIdentifier: "SwitchCell")
        
        let SeeAllCellNib = UINib(nibName: "SeeAllCell", bundle: nil)
        tableView.register(SeeAllCellNib, forCellReuseIdentifier: "SeeAllCell")


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: {});
    }

    
     @IBAction func onSearchButton(_ sender: Any) {
        self.dismiss(animated: true, completion: {});
        
        var filters = [String:AnyObject]()
        
        var selectedCategories = [String]()
        
        for(row,isSelected) in switchStates {
            if isSelected{
                selectedCategories.append(categories[row]["code"]!)
            }
         
            if selectedCategories.count > 0 {
                filters["categories"] = selectedCategories as AnyObject?
            }
        }
        
        for (_, isSelected) in isDealOnState{
            if(isSelected){
                   filters["deal"] = true as AnyObject?
            }
        }
        
        filters["sortBy"] = sortByState.rowSelectedLabel as AnyObject?
        filters["sortByRowIndex"] = sortByState.rowSelected as AnyObject?
        
        filters["distanceRowIndex"] = distanceState.rowSelected as AnyObject?
        filters["distance"] = distanceState.rowSelectedLabel as AnyObject?
        
        
          filters["switchStates"] = switchStates as AnyObject?
        
        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilters: filters)

     }
    
    func yelpCategories() -> [[String: String]] {
        return [["name" : "Afghan", "code": "afghani"],
                ["name" : "African", "code": "african"],
                ["name" : "American, New", "code": "newamerican"],
                ["name" : "American, Traditional", "code": "tradamerican"],
                ["name" : "Arabian", "code": "arabian"],
                ["name" : "Argentine", "code": "argentine"],
                ["name" : "Armenian", "code": "armenian"],
                ["name" : "Asian Fusion", "code": "asianfusion"],
                ["name" : "Asturian", "code": "asturian"],
                ["name" : "Australian", "code": "australian"],
                ["name" : "Austrian", "code": "austrian"],
                ["name" : "Baguettes", "code": "baguettes"],
                ["name" : "Bangladeshi", "code": "bangladeshi"],
                ["name" : "Barbeque", "code": "bbq"],
                ["name" : "Basque", "code": "basque"],
                ["name" : "Bavarian", "code": "bavarian"],
                ["name" : "Beer Garden", "code": "beergarden"],
                ["name" : "Beer Hall", "code": "beerhall"],
                ["name" : "Beisl", "code": "beisl"],
                ["name" : "Belgian", "code": "belgian"],
                ["name" : "Bistros", "code": "bistros"],
                ["name" : "Black Sea", "code": "blacksea"],
                ["name" : "Brasseries", "code": "brasseries"],
                ["name" : "Brazilian", "code": "brazilian"],
                ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                ["name" : "British", "code": "british"],
                ["name" : "Buffets", "code": "buffets"],
                ["name" : "Bulgarian", "code": "bulgarian"],
                ["name" : "Burgers", "code": "burgers"],
                ["name" : "Burmese", "code": "burmese"],
                ["name" : "Cafes", "code": "cafes"],
                ["name" : "Cafeteria", "code": "cafeteria"],
                ["name" : "Cajun/Creole", "code": "cajun"],
                ["name" : "Cambodian", "code": "cambodian"],
                ["name" : "Canadian", "code": "New)"],
                ["name" : "Canteen", "code": "canteen"],
                ["name" : "Caribbean", "code": "caribbean"],
                ["name" : "Catalan", "code": "catalan"],
                ["name" : "Chech", "code": "chech"],
                ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                ["name" : "Chicken Shop", "code": "chickenshop"],
                ["name" : "Chicken Wings", "code": "chicken_wings"],
                ["name" : "Chilean", "code": "chilean"],
                ["name" : "Chinese", "code": "chinese"],
                ["name" : "Comfort Food", "code": "comfortfood"],
                ["name" : "Corsican", "code": "corsican"],
                ["name" : "Creperies", "code": "creperies"],
                ["name" : "Cuban", "code": "cuban"],
                ["name" : "Curry Sausage", "code": "currysausage"],
                ["name" : "Cypriot", "code": "cypriot"],
                ["name" : "Czech", "code": "czech"],
                ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                ["name" : "Danish", "code": "danish"],
                ["name" : "Delis", "code": "delis"],
                ["name" : "Diners", "code": "diners"],
                ["name" : "Dumplings", "code": "dumplings"],
                ["name" : "Eastern European", "code": "eastern_european"],
                ["name" : "Ethiopian", "code": "ethiopian"],
                ["name" : "Fast Food", "code": "hotdogs"],
                ["name" : "Filipino", "code": "filipino"],
                ["name" : "Fish & Chips", "code": "fishnchips"],
                ["name" : "Fondue", "code": "fondue"],
                ["name" : "Food Court", "code": "food_court"],
                ["name" : "Food Stands", "code": "foodstands"],
                ["name" : "French", "code": "french"],
                ["name" : "French Southwest", "code": "sud_ouest"],
                ["name" : "Galician", "code": "galician"],
                ["name" : "Gastropubs", "code": "gastropubs"],
                ["name" : "Georgian", "code": "georgian"],
                ["name" : "German", "code": "german"],
                ["name" : "Giblets", "code": "giblets"],
                ["name" : "Gluten-Free", "code": "gluten_free"],
                ["name" : "Greek", "code": "greek"],
                ["name" : "Halal", "code": "halal"],
                ["name" : "Hawaiian", "code": "hawaiian"],
                ["name" : "Heuriger", "code": "heuriger"],
                ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                ["name" : "Hot Dogs", "code": "hotdog"],
                ["name" : "Hot Pot", "code": "hotpot"],
                ["name" : "Hungarian", "code": "hungarian"],
                ["name" : "Iberian", "code": "iberian"],
                ["name" : "Indian", "code": "indpak"],
                ["name" : "Indonesian", "code": "indonesian"],
                ["name" : "International", "code": "international"],
                ["name" : "Irish", "code": "irish"],
                ["name" : "Island Pub", "code": "island_pub"],
                ["name" : "Israeli", "code": "israeli"],
                ["name" : "Italian", "code": "italian"],
                ["name" : "Japanese", "code": "japanese"],
                ["name" : "Jewish", "code": "jewish"],
                ["name" : "Kebab", "code": "kebab"],
                ["name" : "Korean", "code": "korean"],
                ["name" : "Kosher", "code": "kosher"],
                ["name" : "Kurdish", "code": "kurdish"],
                ["name" : "Laos", "code": "laos"],
                ["name" : "Laotian", "code": "laotian"],
                ["name" : "Latin American", "code": "latin"],
                ["name" : "Live/Raw Food", "code": "raw_food"],
                ["name" : "Lyonnais", "code": "lyonnais"],
                ["name" : "Malaysian", "code": "malaysian"],
                ["name" : "Meatballs", "code": "meatballs"],
                ["name" : "Mediterranean", "code": "mediterranean"],
                ["name" : "Mexican", "code": "mexican"],
                ["name" : "Middle Eastern", "code": "mideastern"],
                ["name" : "Milk Bars", "code": "milkbars"],
                ["name" : "Modern Australian", "code": "modern_australian"],
                ["name" : "Modern European", "code": "modern_european"],
                ["name" : "Mongolian", "code": "mongolian"],
                ["name" : "Moroccan", "code": "moroccan"],
                ["name" : "New Zealand", "code": "newzealand"],
                ["name" : "Night Food", "code": "nightfood"],
                ["name" : "Norcinerie", "code": "norcinerie"],
                ["name" : "Open Sandwiches", "code": "opensandwiches"],
                ["name" : "Oriental", "code": "oriental"],
                ["name" : "Pakistani", "code": "pakistani"],
                ["name" : "Parent Cafes", "code": "eltern_cafes"],
                ["name" : "Parma", "code": "parma"],
                ["name" : "Persian/Iranian", "code": "persian"],
                ["name" : "Peruvian", "code": "peruvian"],
                ["name" : "Pita", "code": "pita"],
                ["name" : "Pizza", "code": "pizza"],
                ["name" : "Polish", "code": "polish"],
                ["name" : "Portuguese", "code": "portuguese"],
                ["name" : "Potatoes", "code": "potatoes"],
                ["name" : "Poutineries", "code": "poutineries"],
                ["name" : "Pub Food", "code": "pubfood"],
                ["name" : "Rice", "code": "riceshop"],
                ["name" : "Romanian", "code": "romanian"],
                ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                ["name" : "Rumanian", "code": "rumanian"],
                ["name" : "Russian", "code": "russian"],
                ["name" : "Salad", "code": "salad"],
                ["name" : "Sandwiches", "code": "sandwiches"],
                ["name" : "Scandinavian", "code": "scandinavian"],
                ["name" : "Scottish", "code": "scottish"],
                ["name" : "Seafood", "code": "seafood"],
                ["name" : "Serbo Croatian", "code": "serbocroatian"],
                ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                ["name" : "Singaporean", "code": "singaporean"],
                ["name" : "Slovakian", "code": "slovakian"],
                ["name" : "Soul Food", "code": "soulfood"],
                ["name" : "Soup", "code": "soup"],
                ["name" : "Southern", "code": "southern"],
                ["name" : "Spanish", "code": "spanish"],
                ["name" : "Steakhouses", "code": "steak"],
                ["name" : "Sushi Bars", "code": "sushi"],
                ["name" : "Swabian", "code": "swabian"],
                ["name" : "Swedish", "code": "swedish"],
                ["name" : "Swiss Food", "code": "swissfood"],
                ["name" : "Tabernas", "code": "tabernas"],
                ["name" : "Taiwanese", "code": "taiwanese"],
                ["name" : "Tapas Bars", "code": "tapas"],
                ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                ["name" : "Tex-Mex", "code": "tex-mex"],
                ["name" : "Thai", "code": "thai"],
                ["name" : "Traditional Norwegian", "code": "norwegian"],
                ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                ["name" : "Trattorie", "code": "trattorie"],
                ["name" : "Turkish", "code": "turkish"],
                ["name" : "Ukrainian", "code": "ukrainian"],
                ["name" : "Uzbek", "code": "uzbek"],
                ["name" : "Vegan", "code": "vegan"],
                ["name" : "Vegetarian", "code": "vegetarian"],
                ["name" : "Venison", "code": "venison"],
                ["name" : "Vietnamese", "code": "vietnamese"],
                ["name" : "Wok", "code": "wok"],
                ["name" : "Wraps", "code": "wraps"],
                ["name" : "Yugoslav", "code": "yugoslav"]]
    }
  }
  
  
  extension FiltersViewController:UITableViewDataSource,SwitchCellDelegate,UITableViewDelegate {
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if(indexPath.section == 3){
            if(categoryExpanded){
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        
        cell.switchLabel.text = categories![indexPath.row]["name"]
        cell.delegate=self
     
        cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
        
        return cell
            }
            else{
                if(indexPath.row == 3){
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SeeAllCell", for: indexPath) as! SeeAllCell
                    return cell
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
                    
                    cell.switchLabel.text = categories![indexPath.row]["name"]
                    cell.delegate=self
                    
                    cell.onSwitch.isOn = switchStates[indexPath.row] ?? false
                    return cell
                }
            }
        }else if(indexPath.section == 1){
            if(distanceExpanded){
                let cell = tableView.dequeueReusableCell(withIdentifier: "Distance", for: indexPath) as! Distance
                cell.distanceLabel.text = getSection(section: indexPath.section).rows[indexPath.row]
                cell.distanceDelegate = self
                if(distanceState.rowSelected == indexPath.row)
                {
                    cell.distanceButton.setImage(doneImage, for: UIControlState.normal)
                    cell.distanceButton.tintColor = UIColor.init(red: CGFloat(0)/255, green: CGFloat(151)/255, blue: (236)/255, alpha: 1)
                }
                else{
                    cell.distanceButton.setImage(notDoneImage, for: UIControlState.normal)
                    cell.distanceButton.tintColor = UIColor.init(red: CGFloat(102)/255, green: CGFloat(102)/255, blue: (102)/255, alpha: 1)
                }
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedDropdownCell", for: indexPath) as! SelectedDropdownCell
                cell.selectedLabel.text = distanceState.rowSelectedLabel
                return cell
            }
        }

        
        else if(indexPath.section == 2){
            if(sortByExpanded){
                let cell = tableView.dequeueReusableCell(withIdentifier: "SortByCell", for: indexPath) as! SortByCell
                cell.sortByLabel.text = getSection(section: indexPath.section).rows[indexPath.row]
                cell.sortByDelegate = self
                if(sortByState.rowSelected == indexPath.row)
                {
                    cell.sortByButton.setImage(doneImage, for: UIControlState.normal)
                    cell.sortByButton.tintColor = UIColor.init(red: CGFloat(0)/255, green: CGFloat(151)/255, blue: (236)/255, alpha: 1)
                }
                else{
                    cell.sortByButton.setImage(notDoneImage, for: UIControlState.normal)
                    cell.sortByButton.tintColor = UIColor.init(red: CGFloat(102)/255, green: CGFloat(102)/255, blue: (102)/255, alpha: 1)//gray
                }
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedDropdownCell", for: indexPath) as! SelectedDropdownCell
                cell.selectedLabel.text = sortByState.rowSelectedLabel
                return cell
            }
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Deal", for: indexPath) as! Deal
            cell.dealDelegate = self
            cell.dealLabel?.text = getSection(section: indexPath.section).rows[indexPath.row]
            cell.dealSwitch.isOn = isDealOnState[indexPath.row] ??  false
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.section == 1){
            distanceExpanded = !distanceExpanded
            tableView.reloadSections(IndexSet(indexPath), with: UITableViewRowAnimation.fade)
        }
        else if(indexPath.section == 2){
            sortByExpanded = !sortByExpanded
            tableView.reloadSections(IndexSet(indexPath), with: UITableViewRowAnimation.fade)
        }
        else if(indexPath.section == 3){
            categoryExpanded = !categoryExpanded
            tableView.reloadSections(IndexSet(indexPath), with: UITableViewRowAnimation.fade)
        }
    }

    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        switchStates[indexPath.row] = value
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return getSection(section: section).sectionLabel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            if(distanceExpanded){
                return getSection(section: section).noOfRows
            }
            else{
                return 1
            }
        }
        else if(section == 2){
            if(sortByExpanded){
                return getSection(section: section).noOfRows
            }
            else{
                return 1
            }
        }
        else if(section == 3){
            if(categoryExpanded){
                return getSection(section: section).noOfRows
            }
            else{
                return 4
            }
        }
        else{
            return getSection(section: section).noOfRows
        }
    }
    
    
    func getSection(section: Int) -> (noOfRows:Int,sectionLabel: String, rowType: String, rows: [String]) {
        var sectionData:(Int,String,String, [String])?
        switch section {
        case 0:
            sectionData = (1,"","Switch",["Offering a Deal"])
        case 1:
            sectionData = (5,"Distance","Dropdown",["Auto","0.3 miles", "1 mile","5 mile","20 miles"])
        case 2:
            sectionData = (3,"Sort By","Dropdown",["Best Match","Distance","Rating"])
        case 3:
            var rowList:[String] = []
            
            for category in categories {
                for(key,value) in category {
                    if(key == "name"){
                        rowList.append("\(value)")
                    }
                }
            }
            
        sectionData = (categories.count,"Category","Dropdown",rowList)
        default:
            break
        }
        return sectionData!
    }

    
  }
  

  
  extension FiltersViewController:SortByCellDelegate
  {
    func sortBySwitchCell(sortBySwitchCell: SortByCell, didChangeValue: Bool) {
        if(didChangeValue){
            let indexPath = tableView.indexPath(for: sortBySwitchCell)!
            sortByState = (rowSelected:indexPath.row,rowSelectedLabel: allSortByOptions[indexPath.row])
            sortByExpanded = !sortByExpanded
            tableView.reloadSections(IndexSet(indexPath), with: UITableViewRowAnimation.fade)
        }
    }

  }
  
  extension FiltersViewController:DistanceDelegate
  {
     func distanceSwitchCell(distanceSwitchCell: Distance, didChangeValue: Bool) {
        if(didChangeValue){
            let indexPath = tableView.indexPath(for: distanceSwitchCell)!
            distanceState = (rowSelected:indexPath.row,rowSelectedLabel: allDistances[indexPath.row])
            distanceExpanded = !distanceExpanded
            tableView.reloadSections(IndexSet(indexPath), with: UITableViewRowAnimation.fade)
        }
    }

  }
  
  extension FiltersViewController:DealDelegate {
    
    func dealSwitchCell(dealSwitchCell: Deal, didChangeValue: Bool) {
        let indexPath = tableView.indexPath(for: dealSwitchCell)!
        isDealOnState[indexPath.row] = didChangeValue
     }
    }
  
  
