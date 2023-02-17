//
//  AuthViewModel.swift
//  HelpMiga
//
//  Created by Ana Letícia Branco on 02/02/23.
//
import SwiftUI
import CryptoKit
import Firebase
import FirebaseFirestoreSwift
import AuthenticationServices
import Combine

typealias SignInWithAppleResult = (authDataResult: AuthDataResult, appleIDCredential: ASAuthorizationAppleIDCredential)

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign ip with error \(error.localizedDescription)")
                return
            }
            
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    
    func registerUser(withEmail email: String, password: String, fullname: String) {
        guard let location = LocationManager.shared.userLocation else { return }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign up with error \(error.localizedDescription)")
                return
            }
            guard let firebaseUser = result?.user else { return }
            self.userSession = firebaseUser
            
            let user = User(
                fullname: fullname,
                email: email,
                uid: firebaseUser.uid,
                coordinates: GeoPoint(latitude: location.latitude, longitude: location.longitude),
                accountMode: .active

            )
            
            self.currentUser = user
            
            guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
            
            Firestore.firestore().collection("users").document(firebaseUser.uid).setData(encodedUser)
        }
    }

        func signout() {
            
            do {
                try Auth.auth().signOut()
                self.userSession = nil
            } catch let error {
                print ("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
            }
            .store(in: &cancellables)
    }

//        // MARK: - SignIn with Apple Functions
    //        
    //        static func signInWithApple(idTokenString: String,
    //                                    nonce: String,
    //                                    completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
    //            // Initialize a Firebase credential.
    //            let credential = OAuthProvider.credential(withProviderID: "apple.com",
    //                                                      idToken: idTokenString,
    //                                                      rawNonce: nonce)
    //            // Sign in with Apple.
    //            Auth.auth().signIn(with: credential) { (authDataResult, err) in
    //                if let err = err {
    //                    // Error. If error.code == .MissingOrInvalidNonce, make sure
    //                    // you're sending the SHA256-hashed nonce as a hex string with
    //                    // your request to Apple.
    //                    print(err.localizedDescription)
    //                    completion(.failure(err))
    //                    return
    //                }
    //                // User is signed in to Firebase with Apple.
    //                guard let authDataResult = authDataResult else {
    //                    completion(.failure(SignInWithAppleAuthError.noAuthDataResult))
    //                    return
    //                }
    //                completion(.success(authDataResult))
    //            }
    //        }
    //        
    //        static func handle(_ signInWithAppleResult: SignInWithAppleResult, completion: @escaping (Result<Bool, Error>) -> ()) {
    //            // SignInWithAppleResult is a tuple with the authDataResult and appleIDCredentioal
    //            // Now that you are signed in, we can update our User database to add this user.
    //            
    //            // First the uid
    //            let uid = signInWithAppleResult.authDataResult.user.uid
    //
    //            // Now Extract the fullname into a single string name
    //            // Note, you only get this object when the account is created.
    //            // All subsequent times, the fullName will be nill so you need to capture it now if you want it for
    //            // your database
    //            
    //            var name = ""
    //            let fullName = signInWithAppleResult.appleIDCredential.fullName
    //            // Extract all three components
    //            let givenName = fullName?.givenName ?? ""
    //            let middleName = fullName?.middleName ?? ""
    //            let familyName = fullName?.familyName ?? ""
    //            let names = [givenName, middleName, familyName]
    //            // remove any names that are empty
    //            let filteredNames = names.filter {$0 != ""}
    //            // Join the names together into a single name
    //            for i in 0..<filteredNames.count {
    //                name += filteredNames[i]
    //                if i != filteredNames.count - 1 {
    //                    name += " "
    //                }
    //            }
    //            
    //            let email = signInWithAppleResult.authDataResult.user.email ?? ""
    //            
    //            let data = user.UserService(uid: uid, fullName: fullName, email: email)
    //            
    //            // Now create or merge the User in Firestore DB
    //            HomeViewModel.fetchUser() { (result) in
    //                completion(result)
    //            }
    //        }
    //        
    //        // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    //        static func randomNonceString(length: Int = 32) -> String {
    //            precondition(length > 0)
    //            let charset: Array<Character> =
    //            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    //            var result = ""
    //            var remainingLength = length
    //            
    //            while remainingLength > 0 {
    //                let randoms: [UInt8] = (0 ..< 16).map { _ in
    //                    var random: UInt8 = 0
    //                    let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
    //                    if errorCode != errSecSuccess {
    //                        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
    //                    }
    //                    return random
    //                }
    //
    //                randoms.forEach { random in
    //                    if length == 0 {
    //                        return
    //                    }
    //                    
    //                    if random < charset.count {
    //                        result.append(charset[Int(random)])
    //                        remainingLength -= 1
    //                    }
    //                }
    //            }
    //            
    //            return result
    //        }
    //        
    //        static func sha256(_ input: String) -> String {
    //            let inputData = Data(input.utf8)
    //            let hashedData = SHA256.hash(data: inputData)
    //            let hashString = hashedData.compactMap {
    //                return String(format: "%02x", $0)
    //            }.joined()
    //            
    //            return hashString
    //        }
    }

