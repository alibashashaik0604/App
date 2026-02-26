import SwiftUI

// MARK: - Message & Chat Models
struct Message: Identifiable, Codable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

struct ChatSession: Identifiable, Codable {
    let id = UUID()
    let messages: [Message]
    let date: Date
}

struct AIResponse: Codable {
    let reply: String
}

// MARK: - Main Chatbot View
struct AIChatbotView: View {
    @State private var messages: [Message] = [
        Message(text: "Hi! I'm your AI assistant. How can I help you?", isUser: false)
    ]
    @State private var userInput: String = ""
    @State private var isSending = false

    @State private var chatHistory: [ChatSession] = []
    @State private var showHistory = false

    var body: some View {
        VStack {
            Text("🧠 AI Chatbot")
                .font(.title2.bold())
                .padding(.top)

            ScrollViewReader { scrollView in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages) { message in
                            HStack {
                                if message.isUser {
                                    Spacer()
                                    Text(message.text)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                        .contextMenu {
                                            Button(action: {
                                                UIPasteboard.general.string = message.text
                                            }) {
                                                Label("Copy", systemImage: "doc.on.doc")
                                            }
                                        }
                                } else {
                                    Text(message.text)
                                        .padding()
                                        .foregroundColor(.black)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(12)
                                        .contextMenu {
                                            Button(action: {
                                                UIPasteboard.general.string = message.text
                                            }) {
                                                Label("Copy", systemImage: "doc.on.doc")
                                            }
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
                .onChange(of: messages.count) { _ in
                    scrollView.scrollTo(messages.last?.id)
                }
            }

            HStack(spacing: 15) {
                Button(action: {
                    if messages.count > 1 {
                        chatHistory.append(ChatSession(messages: messages, date: Date()))
                    }
                    messages = [Message(text: "Hi! I'm your AI assistant. How can I help you?", isUser: false)]
                }) {
                    Label("New Chat", systemImage: "plus.bubble.fill")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .cornerRadius(10)
                }

                Button(action: {
                    showHistory = true
                }) {
                    Label("History", systemImage: "clock.fill")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.orange.opacity(0.2))
                        .foregroundColor(.orange)
                        .cornerRadius(10)
                }
            }
            .padding(.bottom, 5)

            HStack {
                TextField("Ask something...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(isSending)

                Button(action: sendMessage) {
                    if isSending {
                        ProgressView()
                    } else {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                .disabled(userInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSending)
            }
            .padding()
        }
        .sheet(isPresented: $showHistory) {
            HistoryView(history: $chatHistory, loadChat: { selectedChat in
                messages = selectedChat.messages
            })
        }
    }

    // MARK: - Send Message Function
    func sendMessage() {
        let trimmedMessage = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedMessage.isEmpty else { return }

        messages.append(Message(text: trimmedMessage, isUser: true))
        userInput = ""
        isSending = true

        let url = URL(string: ServiceAPI.chatBotURL)!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"message\"\r\n\r\n")
        body.append("\(trimmedMessage)\r\n")
        body.append("--\(boundary)--\r\n")

        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            defer { isSending = false }

            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else { return }

            if let decoded = try? JSONDecoder().decode(AIResponse.self, from: data) {
                DispatchQueue.main.async {
                    messages.append(Message(text: decoded.reply, isUser: false))
                }
            } else {
                print("Failed to decode response")
            }
        }.resume()
    }
}

// MARK: - Chat History View with Delete
struct HistoryView: View {
    @Binding var history: [ChatSession]
    var loadChat: (ChatSession) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                if history.isEmpty {
                    Text("No history yet.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(history.sorted(by: { $0.date > $1.date })) { session in
                        Button(action: {
                            loadChat(session)
                            dismiss()
                        }) {
                            VStack(alignment: .leading) {
                                Text("Chat on \(formattedDate(session.date))")
                                    .font(.headline)
                                Text("\(session.messages.count) messages")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Chat History")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }

    func delete(at offsets: IndexSet) {
        let sorted = history.sorted { $0.date > $1.date }
        for index in offsets {
            if let originalIndex = history.firstIndex(where: { $0.id == sorted[index].id }) {
                history.remove(at: originalIndex)
            }
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - Data Extension
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

// MARK: - Preview
struct AIChatbotView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatbotView()
    }
}
