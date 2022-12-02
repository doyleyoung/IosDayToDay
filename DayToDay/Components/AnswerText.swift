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

struct AnswerText: View {
    var answer: String
    
    var body: some View {
        Text(answer)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .font(.title2)
            .minimumScaleFactor(0.5)
    }
}

struct AnswerSection_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section {
                AnswerText(answer: "100 years, 6 months, 4 weeks, 5 days")
            }
        }
    }
}
