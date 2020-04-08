protocol DevicesPresenter : Presenter {
    
    func deviceClicked(id: String)
    
    func deviceGroupClicked(type: String)
    
    func setView(view: DevicesView)
    
}
