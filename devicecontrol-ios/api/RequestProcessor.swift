protocol RequestProcessor {
    func execute<T>(_ op: @escaping (T) -> Void)
}
