//
//  ViewController.swift
//  SwiftProject
//
//  Created by zlm on 16/6/20.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit
//import Cocoa
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private var _tableView:UITableView!
    private var _dataArr:NSMutableArray = NSMutableArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        _tableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.view.addSubview(_tableView)
        self.view.backgroundColor = UIColor.whiteColor()
        _tableView.sd_layout().topSpaceToView(self.view,10).bottomSpaceToView(self.view,10).leftSpaceToView(self.view,10).rightSpaceToView(self.view,10)
        _tableView.delegate = self
        _tableView.dataSource = self
        //注册cell 会自动init cell
        _tableView.registerClass(ImageCell .classForCoder(), forCellReuseIdentifier: "cell")
        _tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        initData()
//        initNetData()
    }
    
    
    //初始化数据
    func initData() -> Void
    {
        _dataArr.removeAllObjects()
        
        for i in 0 ..< 100
        {
            let subModel = ImageModel()
            subModel._name = "name:"+String(i)
            subModel._imageStr = "http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg"
            
            _dataArr.addObject(subModel)
        }
        _tableView.reloadData()
    }
    //获取网络数据
//    func initNetData() -> Void
//    {
//        NetWorkManage.setIpconfig("image.baidu.com")
//        let data = ["tn":"baiduimage","ct":"201326592","lm":"-1","cl":"2","ie":"gbk","word":"%CD%BC%C6%AC","fr":"ala","ala":"1","alatpl":"others","pos":"0"]
//     
//        NetWorkManage.sendGetRequest(data, trade: "search/index") { (reslut, error) in
//            print("123123123\(reslut)")
//        }
//    }
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return _dataArr.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return tableView.cellHeightForIndexPath(indexPath, model: _dataArr.objectAtIndex(indexPath.row), keyPath: "model", cellClass: ImageCell.classForCoder(), contentViewWidth:UIScreen.mainScreen().bounds.size.width )
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:ImageCell? = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? ImageCell
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.backgroundColor = UIColor.yellowColor()
        
        cell?.model = _dataArr.objectAtIndex(indexPath.row) as! ImageModel//放入数据
        cell?.useCellFrameCacheWithIndexPath(indexPath, tableView: tableView)
        return cell! as UITableViewCell
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

