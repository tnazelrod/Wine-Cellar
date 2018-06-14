//
//  WineViewController.swift
//  wine cellar
//
//  Created by Travis Nazelrod on 5/23/18.
//  Copyright © 2018 Travis Nazelrod. All rights reserved.
//

import UIKit

//Protocols UIPageViewControllerDataSource and UIPageViewControllerDelegate are implemented in extensions to WinePageViewController
class WinePageViewController: UIPageViewController {

    //function to get the viewControllers for the pages by viewController identifiers
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    //create an array of viewControllers for the pages
    fileprivate lazy var pages: [UIViewController] = {
        return[
            self.getViewController(withIdentifier: "sbPageWineListTable"),
            self.getViewController(withIdentifier: "sbPageAddWine"),
            self.getViewController(withIdentifier: "sbPageMap")]
    }()
    
    // var for the page dot indicators
    var pageControl = UIPageControl()
    
    // function to create the page control at the bottom of the screen
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x:0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        self.pageControl.numberOfPages = pages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.darkGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = pages.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        configurePageControl()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

//using extension to encapsulate the code required for each protocol implemented
extension WinePageViewController: UIPageViewControllerDataSource{
    //protocol stubs required for UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return pages.last }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        guard nextIndex <= pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
}

//using extension to encapsulate the code required for each protocol implemented
extension WinePageViewController: UIPageViewControllerDelegate{
    
    //delegate function, update the dot after page turn
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.index(of: pageContentViewController)!
        
    }
    
}










