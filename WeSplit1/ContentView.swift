//
//  ContentView.swift
//  WeSplit1
//
//  Created by Furkan Cingöz on 20.11.2023.
//test

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  @FocusState private var amountIsFocused: Bool

  let tipPercentages = [10,15,20,25,0]

  var totalPerson: Double {
    //calculate the total person here
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelecetion = Double(tipPercentage)

    let tipValue = checkAmount / 100 * tipSelecetion
    let grandTotal = checkAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount

    return amountPerPerson
  }
  var body: some View {
    NavigationView{
      VStack {
        Form {
          Section {
            TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
              .keyboardType(.decimalPad)
              .focused($amountIsFocused)

            Picker("Number of people", selection: $numberOfPeople) {
              ForEach(2..<100) {
                Text("\($0) people")
              }
            }
          }

          Section{

            Picker("Tip percentage", selection: $tipPercentage) {
              ForEach(tipPercentages, id: \.self) {
                Text($0,format: .percent)
              }
            }
            .pickerStyle(.segmented)
          } header : {
            Text("How much tip do you want to leave?") // picker'a header verme baya iyi olay
          }

          Section{
            Text(totalPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
          }
        }.navigationTitle("We Split")
          .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
              Spacer()
              Button("Done") {
                amountIsFocused = false

              }
            }
          }

      }
    }
  }
}

#Preview {
  ContentView()
}
