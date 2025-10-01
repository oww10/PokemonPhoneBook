
import Foundation
import UIKit
import SnapKit
import CoreData

protocol PhoneBookTableViewDelegate: AnyObject {
    func phoneBookTableView(_ tableView: PhoneBookTableView, didSelectRowAt indexPath: IndexPath)
}

class PhoneBookTableView: UIView, UITableViewDataSource, UITableViewDelegate{
    
    private let tableView = UITableView()
    weak var delegate: AddContactDelegate?
    weak var customDelegate: PhoneBookTableViewDelegate?
    
    var phoneBookEntries: [PhoneBookCell.PhoneDatas] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews(){
        self.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PhoneBookCell.self, forCellReuseIdentifier: PhoneBookCell.identifier)
    }
    
    private func setupUI(){
        tableView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBookEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneBookCell.identifier, for: indexPath) as? PhoneBookCell else{
            
            return UITableViewCell()
        }
        
        let phoneData = phoneBookEntries[indexPath.row]
        cell.configureData(phoneDatas: phoneData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        customDelegate?.phoneBookTableView(self, didSelectRowAt: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
