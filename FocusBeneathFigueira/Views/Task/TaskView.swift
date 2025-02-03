import SwiftUI

struct TaskView: View {
    @State var newTask = true
    @State var nameTask = ""
    @State private var tasks: [Task] = []
    @State private var showDeleteAlert = false
    @State private var taskToDelete: Task?
    
    var body: some View {
        VStack(spacing: 35) {
            Text("Tasks")
                .font(Font.custom("Righteous", size: 32))
                .frame(maxWidth: .infinity)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Today")
                        .font(.system(size: 16, weight: .light))
                    
                    Text(currentDate())
                        .font(Font.custom("Righteous", size: 20))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: {
                    newTask.toggle()
                }, label: {
                    Image(newTask ? .closeButton : .editButton)
                })
            }
            
            if newTask {
                VStack(spacing: 16) {
                    TextField("Add a new task...", text: $nameTask)
                        .colorScheme(.dark)
                        .font(.system(size: 16, weight: .light))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 0.41, green: 0.41, blue: 0.41))
                        .cornerRadius(12)
                    
                    Button(action: {
                        addTask()
                    }, label: {
                        Text("Set")
                            .font(Font.custom("Righteous", size: 18))
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.95, green: 0, blue: 0))
                            .cornerRadius(16)
                    })
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                .cornerRadius(12)
            }
            
            if !tasks.isEmpty {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(tasks) { task in
                            HStack(spacing: 10) {
                                Button(action: {
                                    toggleTask(task)
                                }) {
                                    Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                        .font(.system(size: 22))
                                        .foregroundColor(task.isCompleted ? Color(red: 0.95, green: 0, blue: 0) : .white)
                                }
                                            
                                Text(task.name)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.white)
                                    .strikethrough(task.isCompleted, color: .white)
                                            
                                Spacer()
                            }
                            .padding()
                            .background(Color(red: 0.15, green: 0.15, blue: 0.15))
                            .cornerRadius(12)
                            .onLongPressGesture {
                                taskToDelete = task
                                showDeleteAlert = true
                            }
                        }
                    }
                }
                .padding(.top, 16)
            }
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Image(.backBlackScreen)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Task"),
                message: Text("Are you sure you want to delete this task? This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    if let task = taskToDelete {
                        deleteTask(task)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
    }
    
    private func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: Date())
    }
       
    private func addTask() {
        guard !nameTask.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        tasks.append(Task(name: nameTask))
        nameTask = ""
    }
       
    private func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}

#Preview {
    TaskView()
}
