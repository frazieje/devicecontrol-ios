protocol MainView : View {
    func loadChildViews(profileName: String, selectedIndex: Int)
    func setChildViews(_ views: View...)
}
