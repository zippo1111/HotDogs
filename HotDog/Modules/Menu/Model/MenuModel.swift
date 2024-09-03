//
//  MenuModel.swift
//  HotDog
//
//  Created by Mangust on 28.08.2024.
//

struct MenuDataModel {
    let title: String
    let okButtonTitle: String
}

struct MenuModel {
    func getDataModel() -> MenuDataModel {
        MenuDataModel(
            title: "MENU",
            okButtonTitle: "OK"
        )
    }
}
