
import Foundation
import UIKit
import SnapKit
import CoreData

class PhoneBookTableView: UIView, UITableViewDataSource, UITableViewDelegate{
    
    private let tableView = UITableView()
    weak var delegate: ContactDelegate?
    weak var tableViewDelegate: PhoneBookTableViewDelegate?
    
    // 전화번호부 항목들을 저장하는 배열.
    var phoneBookEntries: [PhoneBookCell.PhoneDatas] = [] {
        didSet {
            //데이터가 변경되면 테이블 뷰를 새로고침
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
    
    
    // didSelectRowAt을 이용하여 특정 행이 선택되었을 때 호출하는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 셀이 선택된 후 한번만 애니메이션 출력
        tableView.deselectRow(at: indexPath, animated: true)
        // tableViewDelegate에게 어떤 행이 선택되었는지 알린다.
        tableViewDelegate?.phoneBookTableView(self, didSelectRowAt: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
