//
//  ContentView.swift
//  OnBoarding
//
//  Created by Gabriel Ramos on 31/01/23.
//

import SwiftUI

struct OnBoardingStep {
    let image: String
    let title: String
    let title2: String
    let description: String
}
struct ContentView: View {
    private let onBoardingSteps = [
        OnBoardingStep(image: "onBoarding1", title: "Bem-vinda ao", title2: "\nChega aqui", description: "Agora, você pode rapidamente solicitar \najuda. Não se preocupe mais com situações \nincômodas, nosso app está aqui para ajudar \na qualquer momento."),
        OnBoardingStep(image: "onBoarding2", title: "Entre ou crie", title2: "\nsua conta",description: "Ao utilizar o login com a Apple, garantimos \nmais segurança e privacidade para sua conta. \nCom apenas alguns toques,você pode se \nconectar de maneira rápida e segura."),
        OnBoardingStep(image: "onBoarding3", title: "Permitir acesso", title2: "\na sua localização",description: "Para aproveitar ao máximo a experiencia \ndo nosso app, por favor permita o acesso à \nsua localização sempre, permitindo assim, a \nutilização da localização em tempo real."),
        OnBoardingStep(image: "onBoarding3", title: "Adicione nosso", title2: "\nwidget",description: "Para ter acesso ainda mais rápido ao nosso \nbotão de alertar, recomendamos adicionar o \nnosso widget à sua tela de início. Assim, você \npoderá solicitar ajuda com apenas um toque.")
    ]

    @State private var currentStep = 0
    
    var isTheLastOne:Bool {currentStep == onBoardingSteps.count - 1}
    
    init() {
        UIScrollView.appearance().bounces = false
        UIPageControl.appearance().currentPageIndicatorTintColor = .white
        UIPageControl.appearance().pageIndicatorTintColor = .lightText
    }
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer ()
                Button(action: {
                    self.currentStep = onBoardingSteps .count - 2
                }){
//                    Text ("Skip")
//                        .padding (16)
//                        .foregroundColor (.gray)
                    
                }
            }
            
            TabView (selection: $currentStep){
                ForEach(0..<onBoardingSteps.count) { it in
                    VStack{
                        Image (onBoardingSteps [it].image)
                            .resizable ()
                            .frame (width: UIScreen.main.bounds.width/1, height: UIScreen.main.bounds.height/2.1)
                            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/3.5)
                        
                        
                        Text(onBoardingSteps[it].title)
                            .preferredColorScheme(.light)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .position(x: UIScreen.main.bounds.width/1.7, y: UIScreen.main.bounds.height/2.9)
//                            .padding([.horizontal], 20)
                            .font(.custom("Montserrat-Medium", size: 30))
//                            .bold()
                        
                        Text(onBoardingSteps[it].title2)
                            .preferredColorScheme(.light)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .position(x: UIScreen.main.bounds.width/1.7, y: UIScreen.main.bounds.height/5.7)
//                            .padding([.horizontal], 20)
                            .font(.custom("Montserrat-Bold", size: 30))
//                            .bold()

                        Text(onBoardingSteps[it].description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .position(x: UIScreen.main.bounds.width/1.7, y: UIScreen.main.bounds.height/10)
                            .font(
                                 .custom(
                                 "Inter-Medium",
                                 fixedSize: 15)

                             )
                        Spacer()
                        bottonButton(index: currentStep)
                            .padding(.bottom, 50)
                    }
                    .tag(it)
                }
                

            }
            .background(Color("Cor1"))
            .tabViewStyle(.page)
        }
    }
    
    func bottonButton(index:Int)-> some View {
        if index == 1 {
            return AnyView(SignInButtonView(page: $currentStep))
        }
       
            
            return AnyView(Button(action: {
                withAnimation{
                    currentStep += 1
                }
                print("Vai Planeta!")
            },
                          label: {
                Text(isTheLastOne ? "Vamos Começar" : "Próximo")
                    .padding (14)
                    .frame(maxWidth: .infinity)
                    .background (Color.black)
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .bold()
            }))
    }
    
}

