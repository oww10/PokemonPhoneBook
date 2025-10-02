
import Foundation

protocol ContactDelegate: AnyObject {
    // 새로운 연락처가 성공적으로 추가되었을 때 호출될 함수
    func didAddNewContact()
    // 기존 연락처가 성공적으로 업데이트되었을 때 호출될 함수
    func didUpdateContact()
}


