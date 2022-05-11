//
//  todoapp_otusApp.swift
//  todoapp_otus
//
//  Created by Anna Zharkova on 10.05.2022.
//

import SwiftUI
import SwiftUINavigator

@main
struct todoapp_otusApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationContainerView(transition: .none, content: {TasksListView()
            })
        }
    }
}
