struct ProfileLoginRequestItem {
    var serverUrl: String
    var status: Status
    enum Status {
        case inProgress
        case succeeded
        case failed
    }
}
