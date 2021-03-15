//
//  TextTableControllerViewController.swift
//  Learning
//
//  Created by Banu on 15/03/21.
//

import UIKit

class TextTableController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
}

enum Section: Int {
    case section1
    case section2
    case section3
    case section4
    
    func numOfRows() -> Int {
        switch self {
        case .section1:
            return 2
        case .section2:
            return 5
        case .section3:
            return 3
        case .section4:
            return 6
        }
    }
    func cellIdentifier() -> String {
        switch self {
        case .section1:
            return "TextCellId"
        case .section2:
            return "RightDetailedCellId"
        case .section3:
            return "TextCellId"
        case .section4:
            return "RightDetailedCellId"
        }
    }
}

extension TextTableController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(Section.section4.rawValue)
        return Section.section4.rawValue + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section(rawValue: section)?.numOfRows() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = Section(rawValue: indexPath.section)?.cellIdentifier() ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "Hello section \(indexPath.section + 1)"
        cell.detailTextLabel?.text = "Hello Row \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return "Section Header \(section + 1)"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    
    return "Section Footer \(section + 1)"
}

}
