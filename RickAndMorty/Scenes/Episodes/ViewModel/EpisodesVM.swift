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
    private var fetchedEpisodesData: [Episode]? {
        didSet {
            guard fetchedEpisodesData != nil else { return }
            episodesStore = fetchedEpisodesData!
        }
    }
    
    /// Fetched by Filtering CellViewModels that replace fetched CellViewModels
    ///  while user is searching
    private var filteredEpisodesData: [Episode]? {
        didSet {
            guard filteredEpisodesData != nil else { return }
            episodesStore = filteredEpisodesData!
        }
    }
    
    // MARK: -- Public States --
    
    public var episodesStore = [Episode]() {
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
                populateDataStore(initialData: response.results)
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
                populateDataStore(paginatedData: response.results)
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
                populateDataStore(searchData: response.results)
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
              fetchedEpisodesData != nil
        else {
            episodesStore = fetchedEpisodesData!
            filteredEpisodesData = nil
            
            return
        }
        sendSearchRequest(with: searchText)

    }
    
    /// Paginate if more pages are available and searchedData is nil
    public func paginateIfNeeded(indexPath: IndexPath) {
        guard let maximumPages = maximumPages,
              filteredEpisodesData == nil
        else { return }
        
        
        if indexPath.row == episodesStore.count - 1 &&
            currentPage < maximumPages {
            paginate()
            currentPage += 1
            
        }
    }
    
    /// Get a single Cell VM from cellVM array
    public func getCellData(with indexPath: IndexPath) -> Episode {
        return episodesStore[indexPath.row]
    }
    
    /// Transform fetched Episode Model into Cell ViewModel and append to CellViewModels array
    /// If data is fetched with pagination it appends (+=)  instead of setting it (=)
    private func populateDataStore(initialData: [Episode]? = nil, paginatedData: [Episode]? = nil, searchData: [Episode]? = nil) {
        var data: [Episode]
        
        if let paginatedData = paginatedData {
            data = paginatedData
            if fetchedEpisodesData != nil {
                fetchedEpisodesData! += data
            }
        }
        
        if let initialData = initialData {
            data = initialData
            fetchedEpisodesData = data
        }
        
        if let searchData = searchData {
            data = searchData
            filteredEpisodesData = data
        }
        
    }
    
    /// Get selected episode from an array
    public func getSelectedEpisode(with indexPath: IndexPath) -> Episode {
        return episodesStore[indexPath.row]
    }
    
}
