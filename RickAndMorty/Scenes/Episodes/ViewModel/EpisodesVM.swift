//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by aleksandre on 24.05.22.
//

import Foundation

final class EpisodesViewModel {
    
    // MARK: -- Private States --
    private let networkService: EpisodeService
        
    /// Maximum pages available for pagination
    private var maximumPages: Int?
    
    /// If value changes, it means that pagination is needed
    ///  didset forces to refetch data for updated value( page)
    private var currentPage: Int = 1

    /// Fetched CellViewModels via Initial network request
    /// or by paginating

    /// Keep track of the latest search query
    private var currentSearchQuery: String?

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
    
    /// Stored data // Datasource for TableView
    public var episodesStore: [Episode] = [] {
        didSet {
            reloadNeeded.value = !reloadNeeded.value
        }
    }
    
    /// Observes data changes in the ViewModel array
    public var reloadNeeded: ObservableObject<Bool> = ObservableObject(value: false)
    public var isLoading: ObservableObject<Bool> = ObservableObject(value: false)
    public var internetConnection: ObservableObject<Bool?> = ObservableObject(value: nil)
    
    
    
    init(networkService: EpisodeService) {
        self.networkService = networkService
        /// Check internet connection before making a network call
        if NetworkMonitor.shared.isConnected {
            internetConnection.value = true
            startNetworking()
        } else {
            internetConnection.value = false
        }
    }
    
    /// Initial Network Request
    private func startNetworking() {
        isLoading.value = true
        Task(priority: .background) {
            let result = await networkService.getAllEpisodes(page: currentPage)
            switch result {
            case .success(let response):
                maximumPages = response.info.pages
                populateDataStore(initialData: response.results)
                isLoading.value = false
            case .failure(let error):
                isLoading.value = false
                dump(error)
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
    /// check internet connection before requesting
    private func sendSearchRequest(with searchText: String) {
        guard NetworkMonitor.shared.isConnected else { return }
        Task(priority: .high) {
            let result = await networkService.searchEpisodes(searchText: searchText)
            switch result {
            case .success(let response):
                populateDataStore(searchData: response.results)
            case .failure(let error):
                dump(error)
            }
        }
    }
    
    /// Check searchText before sending a request
    /// if searchText is empty, append  dataSource data with
    /// fetched items and make search dataSource nil
    public func search(with searchText: String) {
        guard searchText != "", fetchedEpisodesData != nil else {
            if fetchedEpisodesData != nil {
                episodesStore = fetchedEpisodesData!
            }
            filteredEpisodesData = nil
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            if searchText == self.currentSearchQuery {
                self.sendSearchRequest(with: searchText)
            }
        }
        currentSearchQuery = searchText
    }
    
    /// Paginate if more pages are available and searchedData is nil
    ///  Check for internet connection before paginating
    public func paginateIfNeeded(indexPath: IndexPath) {
        guard let maximumPages = maximumPages,
              filteredEpisodesData == nil,
              NetworkMonitor.shared.isConnected
        else { return }
        
        if indexPath.row == episodesStore.count - 1 &&
            currentPage < maximumPages {
            paginate()
            currentPage += 1
            
        }
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
