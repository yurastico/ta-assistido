//
//  MovieFormView.swift
//  ta-assistido
//
//  Created by Yuri Cunha on 16/10/23.
//
import SwiftData
import SwiftUI
import PhotosUI

struct MovieFormView: View {
    @Bindable var movie: Movie
    @Binding var path: NavigationPath
    @State private var selectedPoster: PhotosPickerItem?
    @State private var posterImageData: Data? 
    @Environment(\.modelContext) var modelContext
    
    init(movie: Movie? = nil, path: Binding<NavigationPath>) {
        self.movie = movie ?? Movie()
        self._path = path
    }
    
    var body: some View {
        form
        saveButton
        
        
    }
    
    private var form: some View {
        Form {
            Section("Escreva o nome do filme") {
                TextField("Titulo", text: $movie.title)
            }
            Section("Nota e duracao") {
                HStack {
                    //TextField("Nota", value: $movie.rating,formatter: NumberFormatter())
                    TextField("Nota", value: $movie.rating,format: .number)
                    TextField("Duracao",text: $movie.duration)
                }
            }
        
            Section("Categorias") {
                TextField("Insira as principais categorias", text: $movie.categories)
            }
            
            Section("Sinopse") {
                TextEditor(text: $movie.summary)
                    .frame(height: 120)
            }
            
            Section("Poster") {
                PhotosPicker(selection: $selectedPoster, matching: .images, preferredItemEncoding: .automatic) {
                    Label("Selecione o poster",systemImage: "photo")
                }
                //.photosPickerStyle(.compact)
                //.photosPickerDisabledCapabilities(.selectionActions)
                //.photosPickerAccessoryVisibility(.hidden)
                if let posterImageData,
                    let uiImage = UIImage(data: posterImageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8)) // corner radius + clipped
                    
                }
            }
        }
        .listSectionSpacing(3)
        .navigationTitle(movie.title.isEmpty ? "Cadastro": movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("",systemImage: "house.fill") {
                path.removeLast(path.count)
                
            }
        }
        .onChange(of: selectedPoster) {
            Task {
                posterImageData = try? await selectedPoster?.loadTransferable(type: Data.self)
                // tente aguardar a exec, quando terminar vc atribui na var
                movie.image = posterImageData
            }
            
        }
    }
    
    private var saveButton: some View {
        Button {
            modelContext.insert(movie)
            path.removeLast()
        } label: {
            Text("Cadastrar filme")
                .padding(.vertical,6)
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .padding(16)
        }
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Movie.self, configurations: configuration)
        let movie =  Movie(title: "Matrix")
        return MovieFormView(movie: movie,path: .constant(NavigationPath()))
            .modelContainer(container)
    } catch {
        fatalError("erro ao criar o preview")
    }
    
        
}

