//
//  LXSwift+Switch.swift
//  LXSwiftFoundationModule
//
//  Created by XL on 2020/10/11.
//  Copyright © 2020 李响. All rights reserved.
//

import UIKit

//MARK: -  Extending properties and methods for UISwitch
extension LXSwiftBasics where Base : UISwitch {
    
    public func setHandle(switchCallBack: ((_ isOn: Bool?) -> ())?){
        base.swiftCallBack = switchCallBack
        base.addTarget(base, action: #selector(base.swiftSwitchAction(_:)), for: .touchUpInside)
    }   
}

private var switchCallBackKey: Void?
extension UISwitch: LXSwiftPropertyCompatible {
    internal typealias Element = Bool
    internal var swiftCallBack: SwiftCallBack? {
        set {
            objc_setAssociatedObject(self, &switchCallBackKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &switchCallBackKey)  as? SwiftCallBack
        }
    }
    
    @objc internal func swiftSwitchAction(_ event: UISwitch) {
        self.swiftCallBack?(event.isOn)
    }
    
}
