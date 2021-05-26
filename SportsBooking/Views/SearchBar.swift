//
//  SearchBar.swift
//  SportsBooking
//
//  Created by Tarlan Askaruly on 11.05.2021.
//

import SwiftUI

//
//  SearchBar.swift
//  SwiftUI_Search_Bar_in_Navigation_Bar
//
//  Created by Geri Borbás on 2020. 04. 27..
//  Copyright © 2020. Geri Borbás. All rights reserved.
//
//import SwiftUI
//
//class SearchBar: NSObject, ObservableObject {
//
//    @Published var text: String = ""
//    let searchController: UISearchController = UISearchController(searchResultsController: nil)
//
//    override init() {
//        super.init()
//        self.searchController.obscuresBackgroundDuringPresentation = false
//        self.searchController.searchResultsUpdater = self
//    }
//}
//
//extension SearchBar: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//
//        // Publish search bar text changes.
//        if let searchBarText = searchController.searchBar.text {
//            self.text = searchBarText
//        }
//    }
//}
//
//struct SearchBarModifier: ViewModifier {
//
//    let searchBar: SearchBar
//
//    func body(content: Content) -> some View {
//        content
//            .overlay(
//                ViewControllerResolver { viewController in
//                    viewController.navigationItem.searchController = self.searchBar.searchController
//                }
//                    .frame(width: 0, height: 0)
//            )
//    }
//}
//
//extension View {
//
//    func add(_ searchBar: SearchBar) -> some View {
//        return self.modifier(SearchBarModifier(searchBar: searchBar))
//    }
//}
//
////
////  ViewControllerResolver.swift
////  SwiftUI_Search_Bar_in_Navigation_Bar
////
////  Created by Geri Borbás on 2020. 04. 27..
////  Copyright © 2020. Geri Borbás. All rights reserved.
////
//import SwiftUI
//
//final class ViewControllerResolver: UIViewControllerRepresentable {
//
//    let onResolve: (UIViewController) -> Void
//
//    init(onResolve: @escaping (UIViewController) -> Void) {
//        self.onResolve = onResolve
//    }
//
//    func makeUIViewController(context: Context) -> ParentResolverViewController {
//        ParentResolverViewController(onResolve: onResolve)
//    }
//
//    func updateUIViewController(_ uiViewController: ParentResolverViewController, context: Context) { }
//}
//
//class ParentResolverViewController: UIViewController {
//
//    let onResolve: (UIViewController) -> Void
//
//    init(onResolve: @escaping (UIViewController) -> Void) {
//        self.onResolve = onResolve
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("Use init(onResolve:) to instantiate ParentResolverViewController.")
//    }
//
//    override func didMove(toParent parent: UIViewController?) {
//        super.didMove(toParent: parent)
//
//        if let parent = parent {
//            onResolve(parent)
//        }
//    }
//}


struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false

    private let placeholderFontColor = "#3c827b"
    private let textFontColor = "#000000"

    var body: some View {

        HStack {
            TextField("Поиск футбольного поля", text: $text)
                .padding(10)
                .padding(.leading, 30)
                .background(Color.white)
                .foregroundColor(text.count > 0 ? Color.init(hex: textFontColor) : Color.init(hex: placeholderFontColor))
                .cornerRadius(8)
                //.modifier(ClearButton(text: $text))
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.secondary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)


                    }
                )
        }
        .onAppear{
            UITextField.appearance().clearButtonMode = .whileEditing
        }
    }
}

struct ClearButton: ViewModifier
{
    @Binding var text: String

    public func body(content: Content) -> some View
    {
        ZStack(alignment: .trailing)
        {
            content

            if !text.isEmpty
            {
                Button(action: {
                    text = ""
                }){
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.secondary)
                        .padding(.trailing, 8)
                }
            }
        }
    }
}

//struct SearchBar: View {
//    @State var search = ""
//    @Environment(\.colorScheme) var colorScheme
//
//
//
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9580881, green: 0.10593573, blue: 0.3403331637, alpha: 1)), colorScheme == .dark ? Color.black : Color(#colorLiteral(red: 0.9843164086, green: 0.9843164086, blue: 0.9843164086, alpha: 1))]), startPoint: .top, endPoint: .bottom)
//                .frame(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height)*0.25, alignment: .center)
//                .padding(.top, 20)
//                .edgesIgnoringSafeArea(.all)
//
//
//            VStack {
//                HStack {
//                    Text("Главная")
//                        .bold()
//                        .font(.title)
//                        .multilineTextAlignment(.trailing)
//                        .foregroundColor(.white)
//                        .padding(.leading, 20)
//                        //.padding(.top, -40)
//                    Spacer()
//                    Button(action: {
//
//                    }, label: {
//                        HStack {
//                            Text("Нур-Султан")
//                                .font(.headline)
//                                .multilineTextAlignment(.leading)
//                                .foregroundColor(.white)
//                            Image("pin")
//                                .renderingMode(.template)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 25, height: 25)
//                                .foregroundColor(Color.white)
//                                .padding(.trailing, 20)
//
//                        }
//                    })
//                }
////                HStack {
////                    Image(systemName: "magnifyingglass")
////                        .foregroundColor(.gray)
////                        .font(.title)
////                    TextField("Название помещения...", text: $search)
////                        .font(.title3)
////                        .colorScheme(.light)
////                }
////                .frame(width:  ( UIScreen.main.bounds.width)*0.85, height: 40, alignment: .leading)
////                .padding(.leading, 20)
////                .background(Color.white)
////                .cornerRadius(10)
//
//            }
//        }
//    }
//}
//

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}


@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
