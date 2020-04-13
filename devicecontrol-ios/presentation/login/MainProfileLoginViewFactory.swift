class MainProfileLoginViewFactory : ProfileLoginViewFactory {
    
    func addProfileLogin(presenter: AddProfileLoginPresenter) -> AddProfileLoginView {
        let view = AddProfileLoginViewController(presenter: presenter)
        presenter.setView(view: view)
        return view
    }
    
    func editProfileLogin(presenter: EditProfileLoginPresenter, _ item: ProfileServerItem?) -> EditProfileLoginView {
        let view = EditProfileLoginViewController(presenter: presenter)
        presenter.setView(view: view)
        if let strongItem = item {
            view.prefill(with: strongItem)
        }
        return view
    }
    
}
