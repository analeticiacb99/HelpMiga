//
//  HomeView.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 24/01/23.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false 
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            } else if let user = authViewModel.currentUser {
                
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: user )
                        }
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                    }
                }
            }
        }
    }
}

extension HomeView {
    var mapView: some View {
        ZStack (alignment: .bottom) {
            ZStack (alignment: .top) {
                HelpMigaMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .noInput {

                    HelpRequestView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()) {

                                mapState = .noInput
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState, showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            
            if let user = authViewModel.currentUser, user.accountMode == .active {
                homeViewModel.viewForState(mapState, user: user)
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                homeViewModel.userLocation = location
            }
        }

        .onReceive(homeViewModel.$help) { help in
            guard let help = help else {
                self.mapState = .noInput
                return
            }
            
            withAnimation(.spring()) {
                switch help.state {
                case .requested:
                    self.mapState = .helpRequested
                case .rejected:
                    self.mapState = .helpRejected
                case .accepted:
                    self.mapState = .helpAccepted
                case .requesterCancelled:
                    self.mapState = .helpCancelledByRequester
                case .helperCancelled:
                    self.mapState = .helpCancelledByHelper
                }
            }
        }
    }

    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(AuthViewModel())
         
      }
   }
}
