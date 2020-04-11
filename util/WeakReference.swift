final class WeakReference<T: AnyObject> {
    weak var unbox: T?
    init(_ value: T) {
        unbox = value
    }
}
