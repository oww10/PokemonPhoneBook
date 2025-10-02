
import Foundation
import UIKit
import CoreData
import SnapKit

class MainVC: UIViewController,ContactDelegate, PhoneBookTableViewDelegate{
    //새 연락처가 추가되었을 때 호출
    func didAddNewContact() {
        readAllData()
    }
    //기존 연락처가 업데이트되었을 때 호출
    func didUpdateContact() {
        readAllData()
    }

    //테이블 뷰의 행을 선택했을 때 호출
    func phoneBookTableView(_ tableView: PhoneBookTableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Tap")
        //선택한 행의 데이터 가져오기
        let selectedData = phoneTableView.phoneBookEntries[indexPath.row]
        let addVC = AddContactVC()
        // CoreData 컨테이너를 AddContactVC에 전달
        addVC.container = self.container
        // AddContactVC의 delegate를 MainVC 자신으로 설정
        addVC.delegate = self
        // 선택된 데이터를 AddContactVC의 contactEdit 속성에 할당
        addVC.contactEdit = selectedData
        print(selectedData.name)
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    

    let phoneTableView = PhoneBookTableView()
    // CoreData 스택의 NSPersistentContainer 인스턴스
    var container: NSPersistentContainer!
    // 전화번호부 항목들을 저장하는 배열
    var phoneBookEntries: [PhoneBookCell.PhoneDatas] = [] {
        didSet {
            phoneTableView.phoneBookEntries = phoneBookEntries
            
        }
    }
    
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "친구 목록"
        
        setupNavigationBar()
        configureView()
        setupUI()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        phoneTableView.tableViewDelegate = self
        
        readAllData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readAllData()
    }
    // 네비게이션 바
    private func setupNavigationBar(){
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        let resetButton = UIBarButtonItem(title: "초기화", style: .plain, target: self, action: #selector(resetButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = resetButton
    }
    
    //[초기화] 버튼
    @objc func resetButtonTapped(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PhoneBook.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        if self.phoneBookEntries.isEmpty {
            let emptyAlert = UIAlertController(title: "알림", message: "삭제할 데이터가 없습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            emptyAlert.addAction(okAction)
            self.present(emptyAlert, animated: true)
            return
        }
        
        
        do{
            try container.viewContext.execute(deleteRequest)
            try container.viewContext.save()
            self.phoneBookEntries.removeAll()
            let removeAlert = UIAlertController(title: "알림", message: "데이터가 삭제되었습니다.", preferredStyle: .alert)
            removeAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(removeAlert, animated: true)
        } catch{
            print("데이터 삭제 실패")
        }
    }
    
    //[추가] 버튼
    @objc func addButtonTapped(){
        let addContactVC = AddContactVC()
        addContactVC.container = self.container
        addContactVC.delegate = self
        self.navigationController?.pushViewController(addContactVC, animated: true)
    }
    
    
    func configureView(){
        self.view.addSubview(phoneTableView)
    }
    
    
    func setupUI(){
        phoneTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // CoreData에서 모든 전화번호부 데이터를 phoneBookEntries 배열에 저장
    func readAllData() {
        do {
            self.phoneBookEntries.removeAll()
            
            let fetchRequest: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
                                        
            // [name]을 기준으로 오름차순 정렬
            let sortingDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortingDescriptor]
            
            let phoneBooks = try self.container.viewContext.fetch(fetchRequest) as [PhoneBook]
            
            //가져온 PhoneBook 객체들을 PhoneBookCell.PhoneDatas 타입으로 바꿔 phoneBookEntries에 추가
            for phonebook in phoneBooks {
                if let name = phonebook.name,
                   let phoneNumber = phonebook.phoneNumber {
                    let image = phonebook.image
                    
                    let newData = PhoneBookCell.PhoneDatas(name: name, phone: phoneNumber, image: image)
                    self.phoneBookEntries.append(newData)
                }
            }
            
        } catch {
            print("데이터 읽기 실패: \(error)")
        }
    }
    
    
}
