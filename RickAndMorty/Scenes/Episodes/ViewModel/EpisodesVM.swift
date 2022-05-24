//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

final class EpisodesViewModel
{
    
    // MARK: -- Private States --
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
    
    /// Fetched CellViewModels
    private var fetchedVMData: [EpisodeCellViewModel]? {
        didSet {
            guard fetchedVMData != nil else { return }
            episodeCellVMs = fetchedVMData!
        }
    }
    
    /// Fetched by Filtering CellViewModels that replace fetched CellViewModels
    ///  while user is searching
    private var filteredVMData: [EpisodeCellViewModel]? {
        didSet {
            guard filteredVMData != nil else { return }
            episodeCellVMs = filteredVMData!
        }
    }
    
    // MARK: -- Public States --
    
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
                dump(error)
            }
        }
    }
    
    /// Search Network Request
    private func sendSearchRequest(with searchText: String) {
        Task(priority: .background) {
            let result = await networkService.searchEpisodes(searchText: searchText)
            switch result {
            case .success(let response):
                populateCellVMArray(searchData: response.results)
            case .failure(let error):
                dump(error)
            }
        }
    }
    
    /// Check text before sending a request
    ///  Also limit search requests by canceling
    ///   DispatchWorkItem if spammed
    public func search(with searchText: String) {
        guard searchText != "",
              fetchedVMData != nil
        else {
            filteredVMData = nil
            episodeCellVMs = fetchedVMData!
            return
        }
        sendSearchRequest(with: searchText)

    }
    
    /// Paginate if more pages are available and searchedData is nil
    public func paginateIfNeeded(indexPath: IndexPath) {
        guard let maximumPages = maximumPages,
              filteredVMData == nil
        else { return }
        
        
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
    private func populateCellVMArray(initialData: [Episode]? = nil, paginatedData: [Episode]? = nil, searchData: [Episode]? = nil) {
        var cellVMs: [EpisodeCellViewModel]
        
        if let paginatedData = paginatedData {
            cellVMs = paginatedData.map { EpisodeCellViewModel(episodeModel: $0.self)}
            if fetchedVMData != nil {
                fetchedVMData! += cellVMs
            }
        }
        
        if let initialData = initialData {
            cellVMs = initialData.map { EpisodeCellViewModel(episodeModel: $0.self)}
            fetchedVMData = cellVMs
        }
        
        if let searchData = searchData {
            cellVMs = searchData.map { EpisodeCellViewModel(episodeModel: $0.self)}
            filteredVMData = cellVMs
        }
        
    }
    
}
