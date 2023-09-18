//
//  ContentView.swift
//  measurementConverter
//
//  Created by Ygor Simoura on 01/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inicialTemperature = 00.0
    @State private var inputMeasurementUnit = "°C"
    @State private var outputMeasurementUnit = "°C"
    @FocusState private var amountIsFocused: Bool
    
    func resolttemperature() -> Double {
        if inputMeasurementUnit == "°C" && outputMeasurementUnit == "°F"{
            let resolt = (inicialTemperature * 9 / 5) + 32
            return resolt
        } else if inputMeasurementUnit == "°C" && outputMeasurementUnit == "K"{
            let resolt = inicialTemperature + 273.15
            return resolt
        } else if inputMeasurementUnit == "°F" && outputMeasurementUnit == "°C"{
            let resolt = (inicialTemperature - 32) * 5/9
            return resolt
        } else if inputMeasurementUnit == "°F" && outputMeasurementUnit == "K"{
            let resolt = (inicialTemperature - 32) * 5/9 + 273.15
            return resolt
        } else if inputMeasurementUnit == "K" && outputMeasurementUnit == "°F"{
            let resolt = (inicialTemperature - 273.15) * 9/5 + 32
            return resolt
        } else if inputMeasurementUnit == "K" && outputMeasurementUnit == "°C"{
            let resolt = inicialTemperature - 273.15
            return resolt
        } else {
            return inicialTemperature
        }
                
    }
        
    let measurementUnits = ["°C","°F","K"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Inicial", value: $inicialTemperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Input Measurement", selection: $inputMeasurementUnit){
                        ForEach(measurementUnits, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                } header: {
                    Text("What is the temperature?")
                }
                
                Section{
                    Picker("Output Measurements", selection: $outputMeasurementUnit){
                        ForEach(measurementUnits, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select the Temperature unit")
                }
                
                Section {
                    HStack {
                        Spacer()
                        Text(resolttemperature(), format: .number).font(.system(size: 60))
                        Spacer()
                    }
                    .frame(height:110)
                } header: {
                    Text("Resolt")
                }
            }
            .navigationTitle("TempConvert")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
