
import Foundation
import UIKit
import SnapKit

class PhoneBookTableView: UIView, UITableViewDataSource, UITableViewDelegate{
    
    let tableView = UITableView()
    weak var delegate: AddContactDelegate?
    
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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
