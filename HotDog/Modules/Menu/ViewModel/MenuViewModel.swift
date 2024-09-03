//
//  MenuViewModel.swift
//  HotDog
//
//  Created by Mangust on 28.08.2024.
//

struct MenuDataViewModel {
    let title: String
    let okButtonTitle: String
}

struct MenuViewModel {
    init(model: MenuModel?) {
        self.model = model
    }

    func getViewModel() -> MenuDataViewModel? {
        guard let data = model?.getDataModel() else {
            return nil
        }

        return MenuDataViewModel(
            title: data.title,
            okButtonTitle: data.okButtonTitle
        )
    }

    private let model: MenuModel?
}
