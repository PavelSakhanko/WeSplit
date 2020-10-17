//
//  ContentView.swift
//  WeSplit
//
//  Created by Pavel Sakhanko on 12.10.20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let amountWithoutPersents = Double(checkAmount) ?? 0
        let persents = amountWithoutPersents / 100 * Double(tipPercentages[tipPercentage])
        
        return (amountWithoutPersents + persents) / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Text("$\(totalPerPerson, specifier: "%2.f")")
                }
            }
            .navigationBarTitle("We Split")
            
            HStack(alignment: .center, spacing: 30, content: {
                Spacer()
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
