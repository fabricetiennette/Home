import Foundation

extension Double {

    func convertTimestampToStringDate() -> String {
        let int = String(self)
        let newInt = int.replacingOccurrences(of: "0", with: "")
        let date = Date(timeIntervalSince1970: Double(newInt) ?? 0.0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "CET")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd / MM / yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
