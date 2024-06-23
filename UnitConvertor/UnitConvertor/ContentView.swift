import SwiftUI
import Foundation

struct ContentView: View {
    @State private var inputValue = ""
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"
    
    let units = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    
    var outputValue: Double {
        let inputValue = Double(self.inputValue) ?? 0
        return convert(value: inputValue, from: inputUnit, to: outputUnit)
    }
    
    var body: some View {
        VStack {
            TextField("Enter value", text: $inputValue)
                .keyboardType(.decimalPad)
                .padding()
                .border(Color.black, width: 1)
                .cornerRadius(5)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Input Unit")
                    .font(.headline)
                Picker("Input Unit", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            VStack(alignment: .leading) {
                Text("Output Unit")
                    .font(.headline)
                Picker("Output Unit", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            Text("\(outputValue, specifier: "%.2f")")
                .padding()
                .font(.largeTitle)
            
            Spacer()
        }
        .padding()
    }
    
    func convert(value: Double, from inputUnit: String, to outputUnit: String) -> Double {
        var baseValue: Double = 0.0
        
        // Convert to meters
        switch inputUnit {
        case "Meters":
            baseValue = value
        case "Kilometers":
            baseValue = value * 1000
        case "Feet":
            baseValue = value * 0.3048
        case "Yards":
            baseValue = value * 0.9144
        case "Miles":
            baseValue = value * 1609.34
        default:
            baseValue = value
        }
        
        // Convert from base unit to output unit
        switch outputUnit {
        case "Meters":
            return baseValue
        case "Kilometers":
            return baseValue / 1000
        case "Feet":
            return baseValue / 0.3048
        case "Yards":
            return baseValue / 0.9144
        case "Miles":
            return baseValue / 1609.34
        default:
            return baseValue
        }
    }
}

#Preview {
    ContentView()
}
