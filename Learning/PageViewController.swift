//
//  PageViewController.swift
//  Learning
//
//  Created by Banu on 16/03/21.
//

import UIKit

class PageViewController: UIPageViewController {
    var controllers = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = storyboard?.instantiateViewController(identifier: "View1")
        let view2 = storyboard?.instantiateViewController(identifier: "View2")
        let view3 = storyboard?.instantiateViewController(identifier: "View3")
        
        controllers = [view1!, view2!,view3!]
        setViewControllers([view2!], direction: .forward, animated: true, completion: { (status) in
        })
        
        dataSource = self
    }
    
}
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return controllers.last
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return controllers.first
    }
}
