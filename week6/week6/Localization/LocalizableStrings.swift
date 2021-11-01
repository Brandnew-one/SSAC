//
//  LocalizableStrings.swift
//  week6
//
//  Created by 신상원 on 2021/11/01.
//

import Foundation

/*
 "tab_home" = "HOME";
 "tab_search" = "Search";
 "tab_calendar" = "Calendar";
 "tab_setting" = "Setting";
 "welcome_text" = "Hello! Nice to meet you!";
 */

enum LocalizableStrings: String {
    
    //case welcome_text
    case tab_home
    case tab_search
    case tab_calendar
    case tab_setting
    case data_backup
    case welcome_text
    
    var localized: String {
        return self.rawValue.localized()
        //return NSLocalizedString(self.rawValue, comment: "")
    }
    
    var localizedSetting: String {
        return self.rawValue.localized(tableName: "Setting")
    }
}
