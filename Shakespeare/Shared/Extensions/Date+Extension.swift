//
//  Date+Extension.swift
//  Shakespeare
//
//  Created by Roschaun Johnson on 7/30/21.
//

import Foundation

extension Date {

    static func dateFromISOString(_ string: String?) -> Date? {
        guard let string = string else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        return dateFormatter.date(from: string)
    }

    static func stringFromDate(_ date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
        return dateFormatter.string(from: date)
    }

}
