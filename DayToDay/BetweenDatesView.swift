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

import SwiftUI

struct BetweenDatesView: View {
    private enum DisplayUnit: Int, CaseIterable, Identifiable {
        case days, weeks, months, full
        
        var id: Self { self }
        
        var title: String {
            switch self {
            case .days: return "Days"
            case .weeks: return "Weeks"
            case .months: return "Months"
            case .full: return "Full"
            }
        }
        
        var allowedUnits: NSCalendar.Unit {
            switch self {
            case .days: return .day
            case .weeks: return .weekOfMonth
            case .months: return .month
            case .full: return [.year, .month, .weekOfMonth, .day]
            }
        }
    }
    
    @State private var beginDate = Date.now.midnight()
    @State private var endDate = Date.now.midnight()
    @State private var displayUnit: DisplayUnit = .days
    
    var body: some View {
        Form {
            Section {
                DateField(title: "Begin Date", selection: $beginDate)
                DateField(title: "End Date", selection: $endDate)
            }
            
            if endDate > beginDate,
               let betweenDates = beginDate.intervalDescription(to: endDate, allowedUnits: displayUnit.allowedUnits) {
                Section {
                    AnswerText(answer: betweenDates)
                } footer: {
                    Picker("Display Unit", selection: $displayUnit) {
                        ForEach(DisplayUnit.allCases) { style in
                            Text(style.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
            }
        }
    }
}

struct BetweenDatesView_Previews: PreviewProvider {
    static var previews: some View {
        BetweenDatesView()
    }
}
