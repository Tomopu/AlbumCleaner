//
//  User.swift
//  AlbumCleaner
//
//  Created by 泉知成 on 2025/10/24.
//

import SwiftUI

struct User: Identifiable {
    var id = UUID().uuidString
    var name: String
    var place: String
    var profilePic: String
}
