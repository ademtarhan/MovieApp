//
//  CoreData.swift
//  MovieApp
//
//  Created by Adem Tarhan on 23.08.2022.
//

import CoreData
import UIKit

protocol CoreData: AnyObject {
    func saveDataOf(movie: [MovieResult])
}

class CoreDataImpl: CoreData {
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
        dlog(self, "willSaveDataFromCoreData")
        context.perform {
            for movie in movies {
                let movieEntity = MovieEntity(context: context)
                movieEntity.image = movie.posterPath
                movieEntity.name = movie.title
                movieEntity.voteAverage = movie.voteAverage
                dlog(self, "didSaveDataFromCoreData")
            }

            do {
                try context.save()
            } catch {
                fatalError("failed save data to core data")
            }
        }
    }
}
