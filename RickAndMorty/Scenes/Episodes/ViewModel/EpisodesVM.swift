//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

final class EpisodesViewModel
{
    
    // MARK: -- Private
    private let networkService: EpisodeService
    
    /// Maximum pages available for pagination
    private var maximumPages: Int?
    
    /// If value changes, it means that pagination is needed
    ///  didset forces to refetch data for updated value( page)
    private var currentPage: Int = 1 {
        didSet {
            print(currentPage)
        }
    }
    
    // MARK: -- Public
    
    public var episodeCellVMs = [EpisodeCellViewModel]() {
        didSet {
            reloadNeeded.value = !reloadNeeded.value
        }
    }
    
    /// Observes data changes in the ViewModel array
    public var reloadNeeded: ObservableObject = ObservableObject(value: false)
    
    
    init(networkService: EpisodeService) {
        self.networkService = networkService
        startNetworking()
        
    }
    
    /// Initial Network Request
    private func startNetworking() {
        Task(priority: .background) {
            let result = await networkService.getAllEpisodes(page: currentPage)
            switch result {
            case .success(let response):
                print(response.info)
                maximumPages = response.info.pages
                populateCellVMArray(initialData: response.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Pagination Network Request
    private func paginate() {
        Task(priority: .background) {
            let result = await networkService.getAllEpisodes(page: currentPage)
            switch result {
            case .success(let response):
                populateCellVMArray(paginatedData: response.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Paginate if more pages are available
    public func paginateIfNeeded(indexPath: IndexPath) {
        guard let maximumPages = maximumPages else { return }
        
        if indexPath.row == episodeCellVMs.count - 1 &&
            currentPage < maximumPages {
            paginate()
            currentPage += 1
            
        }
    }
    
    /// Get a single Cell VM from cellVM array
    public func getCellVM(with indexPath: IndexPath) -> EpisodeCellViewModel {
        return episodeCellVMs[indexPath.row]
    }
    
    /// Transform fetched Episode Model into Cell ViewModel and append to CellViewModels array
    /// If data is fetched with pagination it appends (+=)  instead of setting it (=)
    private func populateCellVMArray(initialData: [Episode]? = nil, paginatedData: [Episode]? = nil) {
        var cellVMs: [EpisodeCellViewModel]
        
        if let paginatedData = paginatedData {
            cellVMs = paginatedData.map { EpisodeCellViewModel(episodeModel: $0.self)}
            episodeCellVMs += cellVMs
        }
        
        if let initialData = initialData {
            cellVMs = initialData.map { EpisodeCellViewModel(episodeModel: $0.self)}
            episodeCellVMs = cellVMs
        }
        
       
    }
    
}
