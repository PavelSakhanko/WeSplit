//
//  ContentView.swift
//  WeSplit
//
//  Created by Pavel Sakhanko on 12.10.20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]

    var totalAmount: Double {
        let amountWithoutPersents = Double(checkAmount) ?? 0
        let persents = amountWithoutPersents / 100 * Double(tipPercentages[tipPercentage])
        return amountWithoutPersents + persents
    }

    var totalPerPerson: Double {
        let number = Double(numberOfPeople)
        return number == nil ? 0.0 : totalAmount / (Double(numberOfPeople) ?? 0.0)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
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
