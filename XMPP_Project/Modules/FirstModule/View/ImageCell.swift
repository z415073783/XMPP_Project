//
//  ImageCell.swift
//  SwiftProject
//
//  Created by zlm on 16/6/21.
//  Copyright © 2016年 zlm. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell
{

//    var _button: UIButton!
    
    var _imageV: UIImageView!
    
    private var _name:UILabel!
    private var _model:ImageModel?
    var model:ImageModel{
        get{
            return _model!
        }
        set{
            _model = newValue
            updateCell(_model!)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    func updateCell(sender:ImageModel) -> Void
    {
        
        let attributeString = NSMutableAttributedString.init(string: sender._name!)
        let keyStr:String = "name:"
        let nameStr = NSString.init(string: sender._name!)
        let nameRange:NSRange = nameStr.rangeOfString(keyStr)
        
        
        attributeString.addAttributes([NSForegroundColorAttributeName as String:UIColor.blackColor()], range: nameRange)
        if _imageV == nil
        {
            _imageV = UIImageView()
            self.addSubview(_imageV)
            _imageV.sd_layout().leftEqualToView(self).topEqualToView(self)
            
        }
        
        if _name == nil
        {
            _name = UILabel.init()
            self.addSubview(_name)
            
            _name.setSingleLineAutoResizeWithMaxWidth(4000);
            _name.sd_layout().leftSpaceToView(_imageV,50).centerXEqualToView(_imageV).centerYEqualToView(_imageV)
            
            _name.isAttributedContent = true
            _name.textColor = UIColor.blueColor()

        }
        _name.attributedText = attributeString
        
        weak var _weakSelf = self
        weak var _weakImageV = _imageV
        _imageV.sd_setImageWithURL(NSURL.init(string: sender._imageStr!)) { (image, error, ImageCacheType, url) in
                _weakImageV!.sd_layout().heightIs(image.size.height).widthIs(image.size.width)
            _weakSelf!.setupAutoHeightWithBottomView(_weakSelf!._imageV, bottomMargin:60)
        }
        
   
    }
    
    
    
    
    
    
    
}
