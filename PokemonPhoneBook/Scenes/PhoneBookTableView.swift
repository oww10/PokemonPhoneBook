//
//  PhoneBookTableVIew.swift
//  PokemonPhoneBook
//
//  Created by oww on 9/29/25.
//

import Foundation
import UIKit
import SnapKit

class PhoneBookTableView: UITableView{
    
    let tableView = UITableView()
    
    var uiImage: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .gray
        img.layer.cornerRadius = 50
        img.layer.borderColor = UIColor.black.cgColor
        return img
    }()
    
    var nameText: UILabel = {
        let label = UILabel()
        label.text = "name"
        return label
    }()
    
    var phoneText: UILabel = {
        let label = UILabel()
        label.text = "010-0000-0000"
        return label
    }()

    
}
