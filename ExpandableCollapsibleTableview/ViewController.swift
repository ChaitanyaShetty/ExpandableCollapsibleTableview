//
//  ViewController.swift
//  ExpandableCollapsibleTableview
//
//  Created by SMSCountry Networks Pvt. Ltd on 05/07/18.
//  Copyright © 2018 SMSCountry Network Pvt.Ltd. All rights reserved.
//

import UIKit

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
    
}

class ViewController: UIViewController {
    
    @IBOutlet var expandTableview: UITableView!
    var sectionNames : NSArray!
    var sectionItems : NSArray!
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var expandedSectionHeaderNumber : NSInteger!
    
    var tableviewData = [cellData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        sectionNames = [ "iPhone", "iPad", "Apple Watch" ];
//        sectionItems = [ ["iPhone 5", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 7",
//                          "iPhone 7 Plus"],
//                         ["iPad Mini", "iPad Air 2", "iPad Pro", "iPad Pro 9.7"],
//                         ["Apple Watch", "Apple Watch 2", "Apple Watch 2 (Nike)"]
//        ];
        
        tableviewData = [cellData(opened: false, title: "iPhone", sectionData: ["iPhone 5", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 7",
                                  "iPhone 7 Plus"]), cellData(opened: false, title: "iPad", sectionData: ["iPad Mini", "iPad Air 2", "iPad Pro", "iPad Pro 9.7"]), cellData(opened: false, title: "Apple Watch", sectionData: ["Apple Watch", "Apple Watch 2", "Apple Watch 2 (Nike)"])]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableviewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableviewData[section].opened == true {
            return tableviewData[section].sectionData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
            cell.textLabel?.text = tableviewData[indexPath.section].title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell()}
            cell.textLabel?.text = tableviewData[indexPath.section].sectionData[dataIndex]
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        if tableviewData[indexPath.section].opened == true {
            tableviewData[indexPath.section].opened = false
            let sections = IndexSet.init(integer : indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableviewData[indexPath.section].opened = true
            let sections = IndexSet.init(integer : indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        }
    }
    
    
 
}
