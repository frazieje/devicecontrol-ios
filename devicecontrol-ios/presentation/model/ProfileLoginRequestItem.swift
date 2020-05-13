struct ProfileLoginRequestItem {
    var serverUrl: String
    var status: Status
    enum Status {
        case ready
        case inProgress
        case succeeded
        case failed
    }
}
