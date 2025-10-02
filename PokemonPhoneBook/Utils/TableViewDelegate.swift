
import Foundation

protocol PhoneBookTableViewDelegate: AnyObject {
    // PhoneBookTableView에서 특정 행이 선택되었을 때 호출될 함수
    func phoneBookTableView(_ tableView: PhoneBookTableView, didSelectRowAt indexPath: IndexPath)
}
