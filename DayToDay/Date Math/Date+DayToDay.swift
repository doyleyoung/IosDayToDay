//
// Copyright © 2022 Doyle Young. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

extension Date {
    func midnight(using calendar: Calendar = .current) -> Date {
        calendar.startOfDay(for: self)
    }
    
    func adding(days: Int, using calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: .day, value: days, to: self)
    }
    
    func intervalDescription(to date: Date, allowedUnits: NSCalendar.Unit) -> String? {
        guard date > self else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = allowedUnits
        return formatter.string(from: self, to: date)
    }
}
