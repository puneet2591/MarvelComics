//
//  AppProtocol.swift
//  SmartMonitor_iOS
//
//  Created by Puneet Mahajan on 09/10/20.
//  Copyright © 2020 Puneet. All rights reserved.
//

import Foundation


protocol BaseProtocol: Decodable {
    
    var code: Int { get }
    var status: String { get }
}
