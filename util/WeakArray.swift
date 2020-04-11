struct WeakArray<T: AnyObject> {
    private var items: [WeakReference<T>] = []

    init(_ elements: [T]) {
        items = elements.map { WeakReference($0) }
    }
}

extension WeakArray: Collection {
    var startIndex: Int { return items.startIndex }
    var endIndex: Int { return items.endIndex }

    subscript(_ index: Int) -> Element? {
        return items[index].unbox
    }

    func index(after idx: Int) -> Int {
        return items.index(after: idx)
    }
}
