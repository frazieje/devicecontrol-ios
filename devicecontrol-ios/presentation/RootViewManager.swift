protocol RootViewManager {
    func getRootView() -> View
    func setRoot(view: View, animated: Bool, wrapWithNavController: Bool)
}
