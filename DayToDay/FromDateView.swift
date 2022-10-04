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

struct FromDateView: View {
    @State private var numberOfDays: Int?
    @State private var fromDate = Date.now
    @FocusState private var isNumberOfDaysFocused
    
    var body: some View {
        Form {
            Section {
                NumberField(
                    title: "Number of Days",
                    placeholder: "Days",
                    value: $numberOfDays,
                    isFocused: $isNumberOfDaysFocused
                )
                
                DateField(title: "From Date", selection: $fromDate)
            }
            
            if let days = numberOfDays, let date = fromDate.adding(days: days) {
                Section {
                    AnswerText(answer: date.formatted(date: .numeric, time: .omitted))
                }
            }
        }
    }
}

struct FromDateView_Previews: PreviewProvider {
    static var previews: some View {
        FromDateView()
    }
}
