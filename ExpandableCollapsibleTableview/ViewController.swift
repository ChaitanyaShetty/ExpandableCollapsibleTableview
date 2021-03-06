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
    
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//     if sectionNames.count > 0 {
//            tableView.backgroundView = nil
//            return sectionNames.count
//        } else {
//            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
//            messageLabel.text = "Retrieving data.\nPlease wait."
//            messageLabel.numberOfLines = 0
//            messageLabel.textAlignment = .center;
//            messageLabel.font = UIFont(name: "HelveticaNeue", size: 20.0)!
//            messageLabel.sizeToFit()
//            self.expandTableview.backgroundView = messageLabel;
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (self.expandedSectionHeaderNumber == section) {
//            let arrOfItems = self.sectionItems[section] as! NSArray
//            return arrOfItems.count
//        } else {
//            return 0
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
//        let section = self.sectionItems[indexPath.section] as! NSArray
//        cell.textLabel?.textColor = UIColor.black
//        cell.textLabel?.text = section[indexPath.row] as? String
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if (self.sectionNames.count != 0) {
//            return self.sectionNames[section] as? String
//        } else {
//            return ""
//        }
//    }
//
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        header.contentView.backgroundColor = UIColor.blue
//        header.textLabel?.textColor = UIColor.white
//        if let viewWithTag = self.view.viewWithTag(header.tag + section) {
//            viewWithTag.removeFromSuperview()
//        }
//
//        let headerFrame = self.view.frame.size
//        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 13, width: 18, height: 18));
//        theImageView.image = UIImage(named: "Chevron-Dn-Wht")
//        theImageView.tag = header.tag + section
//        header.addSubview(theImageView)
//
//        // make headers touchable
//        header.tag = section
//        let headerTapGesture = UITapGestureRecognizer()
//        headerTapGesture.addTarget(self, action: #selector(ViewController.sectionHeaderWasTouched(_:)))
//        header.addGestureRecognizer(headerTapGesture)
//    }
//
//    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
//        let headerView = sender.view as! UITableViewHeaderFooterView
//        let section    = headerView.tag
//        let eImageView = headerView.viewWithTag(headerView.tag + section) as? UIImageView
//        if (self.expandedSectionHeaderNumber == -1) {
//            self.expandedSectionHeaderNumber = section
//            tableViewExpandSection(section, imageView: eImageView!)
//        } else {
//            if (self.expandedSectionHeaderNumber == section) {
//                tableViewCollapeSection(section, imageView: eImageView!)
//            } else {
//                let cImageView = self.view.viewWithTag(headerView.tag + self.expandedSectionHeaderNumber) as? UIImageView
//                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
//                tableViewExpandSection(section, imageView: eImageView!)
//            }
//        }
//    }
//
//    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
//        let sectionData = self.sectionItems[section] as! NSArray
//        self.expandedSectionHeaderNumber = -1;
//        if (sectionData.count == 0) {
//            return;
//        } else {
//            UIView.animate(withDuration: 0.4, animations: {
//                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
//            })
//            var indexesPath = [IndexPath]()
//            for i in 0 ..< sectionData.count {
//                let index = IndexPath(row: i, section: section)
//                indexesPath.append(index)
//            }
//            self.expandTableview!.beginUpdates()
//            self.expandTableview!.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
//            self.expandTableview!.endUpdates()
//        }
//    }
//
//
//    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
//        let sectionData = self.sectionItems[section] as! NSArray
//        if (sectionData.count == 0) {
//            self.expandedSectionHeaderNumber = -1;
//            return;
//        } else {
//            UIView.animate(withDuration: 0.4, animations: {
//                imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
//            })
//            var indexesPath = [IndexPath]()
//            for i in 0 ..< sectionData.count {
//                let index = IndexPath(row: i, section: section)
//                indexesPath.append(index)
//            }
//            self.expandedSectionHeaderNumber = section
//            self.expandTableview!.beginUpdates()
//            self.expandTableview!.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
//            self.expandTableview!.endUpdates()
//        }
//    }

}
