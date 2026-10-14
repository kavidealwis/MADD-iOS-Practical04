import SwiftUI

struct ContentView: View {

    // Part B – State Variables
    @State private var students: [Student] = []

    @State private var studentName = ""

    @State private var markText = ""

    var body: some View {

        NavigationStack {

            VStack {

                // Part C – Build the Input Interface
                TextField(
                    "Student Name",
                    text: $studentName
                )
                .textFieldStyle(.roundedBorder)
                .padding()

                TextField(
                    "Mark",
                    text: $markText
                )
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding()

                // Part D – Add a Student
                Button("Add Student") {

                    guard !studentName.isEmpty else {
                        return
                    }

                    guard let mark = Int(markText) else {
                        return
                    }

                    guard mark >= 0 && mark <= 100 else {
                        return
                    }

                    let student = Student(
                        name: studentName,
                        mark: mark
                    )

                    students.append(student)

                    studentName = ""
                    markText = ""
                }
                .buttonStyle(.borderedProminent)

                // Part G – Passed Student Count
                Text("Passed Students: \(students.filter { $0.passed }.count)")
                    .font(.title2)
                    .padding()

                // Part E – Display the Student List
                List(students) { student in

                    NavigationLink {
                        StudentDetailView(student: student)
                    } label: {

                        HStack {

                            Text(student.name)

                            Spacer()

                            Text("\(student.mark)")
                                .bold()
                                .foregroundStyle(
                                    student.passed ? .green : .red
                                )

                            Text(student.passed ? "Pass" : "Fail")
                                .foregroundStyle(
                                    student.passed ? .green : .red
                                )
                        }
                    }
                }
            }
            .navigationTitle("SE4041 Marks")
        }
    }
}

#Preview {
    ContentView()
}
