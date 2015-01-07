//
//  ViewController.swift
//  ScreenshotSwift
//
//  Created by QiMENG on 1/7/15.
//  Copyright (c) 2015 QiMENG. All rights reserved.
//  QQ:3050700400

import UIKit

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var shotImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bar:UIBarButtonItem = UIBarButtonItem(title: "Shot",
            style: UIBarButtonItemStyle.Done,
            target: self,
            action: "touchShot")
        
        self.navigationItem.rightBarButtonItem = bar;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        if indexPath.row % 2 == 0{
            
            cell.imageView?.image = UIImage(named: "qimeng")
        }else {
            cell.imageView?.image = nil
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50;
    }

    /**
    生成截图
    */
    func touchShot() {
        
        var shotImage: UIImage = UIImage()
        
        for index in 0...49 {

            let cell: UITableViewCell = self.tableView(myTableView, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0))
            
            let image0: UIImage = self.captureView(cell)
            
            if index == 0 {
                
                shotImage = image0
                
            }else {
                
                shotImage = self.compositePicture(shotImage, aImage2: image0)
            }
            
        }
        
        shotImageView.image = shotImage

    }
    
    /**
    将视图转换成图片
    
    :param: aView 视图
    
    :returns: 视图对应的截图
    */
    func captureView(aView: UIView) -> UIImage {
        
        let rect:CGRect = aView.frame
        
        UIGraphicsBeginImageContext(rect.size)
        
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        
        aView.layer.renderInContext(context)
        
        var resultingImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultingImage
    }
    /**
    合成两张图片
    
    :returns: 合成图
    */
    func compositePicture(aImage1: UIImage, aImage2: UIImage) -> UIImage {
        
        let size = CGSizeMake(aImage1.size.width, aImage1.size.height + aImage2.size.height)
        
        UIGraphicsBeginImageContext(size);
        
        aImage1.drawInRect(CGRectMake(0, 0, aImage1.size.width, aImage1.size.height))
        
        aImage2.drawInRect(CGRectMake(0, aImage1.size.height, aImage2.size.width, aImage2.size.height))
        
        var resultingImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resultingImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

