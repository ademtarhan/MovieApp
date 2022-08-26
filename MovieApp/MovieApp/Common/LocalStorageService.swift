//
//  CoreData.swift
//  MovieApp
//
//  Created by Adem Tarhan on 23.08.2022.
//

import CoreData
import UIKit
import Alamofire

protocol LocalStorageService: AnyObject {
    var view: HomeViewController? { get set }
    func saveDataOf(movie: [MovieResult])
    func fetch()
    func updateDataOffNetwork()
}

class LocalStorageServiceImpl: NSManagedObject, LocalStorageService {
    var view: HomeViewController?
    var movieArray = [MovieResult]()

    private let container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    private let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")

    func saveDataOf(movie: [MovieResult]) {
        container?.performBackgroundTask({ [self] context in
            deleteObjectFromCoreData(context: context)
            saveDataInCoreData(movies: movie, context: context)
        })
    }

    private func deleteObjectFromCoreData(context: NSManagedObjectContext) {
        dlog(self, "willDeleteObjectFromCoreData")
        do {
            let object = try context.fetch(fetchRequest)
            _ = object.map({ context.delete($0) })
            dlog(self, "didDeleteObjectFromCoreData")

            try context.save()
        } catch {
            dlog(self, "didNotDeletedObjectFromCoreData")
        }
    }

    private func saveDataInCoreData(movies: [MovieResult], context: NSManagedObjectContext) {
        let group = DispatchGroup()
        dlog(self, "willSaveDataFromCoreData")
        context.perform {
            for movie in movies {
                let movieEntity = MovieEntity(context: context)
                movieEntity.image = movie.posterPath
                movieEntity.name = movie.title
                movieEntity.voteAverage = movie.voteAverage
                let item = MovieResult(posterPath: movieEntity.image!, title: movieEntity.name!, voteAverage: movieEntity.voteAverage)
                self.movieArray.append(item)
                
            }
            dlog(self, "didSaveDataFromCoreData")
            do {
                try context.save()
            } catch {
                fatalError("failed save data to core data")
            }
        }
        
    }
    func updateDataOffNetwork(){
        if !NetworkReachabilityManager()!.isReachable{
            self.view?.update(movies: movieArray)
            
        }
    }

    func fetch() {
        /*
         do {
             movieArray = try container?.viewContext.fetch(MovieEntity.fetchRequest()) as! [MovieResult]
         } catch {
             dlog(self, "1234567")
         }

                  container?.performBackgroundTask({ [self] context in
                      let object = try? context.fetch(fetchRequest)
                      object.map { movie in
                          dlog(self, movie)
                      }
          //            guard let name = object["title"] as? String,
          //                  let voteAverage = object["voteAverage"] as? String,
          //                    let image = object["image"] as? String
          //            else { return}
          //            let item = MovieResult(posterPath: image, title: name, voteAverage: voteAverage)
                      // movieArray.append(item)
                      dlog(self, "object- \(object)")
                  })
                   */
    }
}
