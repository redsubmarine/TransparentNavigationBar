//
//  ViewController.swift
//  TitleAnimation
//
//  Created by 양원석 on 2015. 4. 17..
//  Copyright (c) 2015년 양원석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet
    weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCells()
        self.navigationItem.titleView = titleView()
        self.navigationItem.titleView?.alpha = 0.0
        
        self.navigationController?.navigationBar.setBackgroundImage(imageWithColor(UIColor(white: 1.0, alpha: 0.0)), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func registerCells() {
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.registerNib(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
    }
    
    func titleView() -> UIView {
        let titleView = UIView(frame: CGRectMake(0, 0, 200, 40))
        let label = UILabel(frame: titleView.bounds)
        label.text = "Remember 2014.04.16"
        label.textAlignment = .Center
        titleView.addSubview(label)
        return titleView
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let alpha = max(min(60, offset), 0)
        self.navigationItem.titleView?.alpha = offset/60
        self.navigationController?.navigationBar.setBackgroundImage(imageWithColor(UIColor(white: 1.0, alpha: offset/60)), forBarMetrics: .Default)

    }
}


extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell;
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCell
            return cell;
        }
        cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = "\(indexPath.row) Index"
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 320.0
        }
        return 44.0
    }
}

func imageWithColor(color: UIColor) -> UIImage {
    let rect = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}