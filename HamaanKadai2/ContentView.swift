//
//  ContentView.swift
//  HamaanKadai2
//
//  Created by 浜崎良 on 2024/01/22.
//

import SwiftUI
enum FourArithmeticOperators: String, CaseIterable, Identifiable {
    var id: Self { self } //自分自身のインスタンスをidプロパティとして扱う
    case addition = "+"
    case subtraction = "-"
    case division = "×"
    case multiplication = "÷"
}

struct ContentView: View{
    @State private var num1 = ""
    @State private var num2 = ""
    @State private var selectedValue: FourArithmeticOperators? = nil //未選択状態にするためOptional
    @State private var total: String = ""

    var body: some View {
        TextField("", text: $num1)
            .textfieldModifier()
        TextField("", text: $num2)
            .textfieldModifier()
        Picker("", selection: $selectedValue) {
            ForEach(FourArithmeticOperators.allCases) { fourArithmeticOperator in
                Text(fourArithmeticOperator.rawValue).tag(Optional(fourArithmeticOperator))
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 200)
        
        Button("Button") {
            let stringNums = [num1, num2]
            
            let doubleNums = stringNums.map { Double($0) ?? 0 }
            
            //🟥テキストフィールドに数字が入力されていない時に"数字を入力してください"を表示する
            if !num1.isEmpty && !num2.isEmpty {
                calculatorBySelectedValue(doubleNums: doubleNums)
            } else {
                total = "数字を入力してください"
            }
        }
        Text(total)
    }
    
    func calculatorBySelectedValue (doubleNums: [Double]) {
        //🟥selectedValue(FourArithmeticOperators列挙型)のケースによって処理を分ける
        switch selectedValue {
        case .addition:
            total = String(doubleNums[0] + doubleNums[1])
        case .subtraction:
            total = String(doubleNums[0] - doubleNums[1])
        case .division:
            total = String(doubleNums[0] * doubleNums[1])
        case .multiplication:
            //割る数(doubleNums[1])が0の場合に"割る数には0を入力してください"を表示
            if doubleNums[1] == 0 {
                total = "割る数には0を入力してください"
            } else {
                total = String(doubleNums[0] / doubleNums[1])
            }
            
            //selectedValueがnilの場合に"計算方法を選択してください"を表示
        case nil:
            total = "計算方法を選択してください"
        }
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 200)
            .textFieldStyle(.roundedBorder)
    }
}

extension View {
    func textfieldModifier() -> some View {
        modifier(TextFieldModifier())
    }
}

#Preview {
    ContentView()
}
