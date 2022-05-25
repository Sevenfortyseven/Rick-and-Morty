//
//  CharacterService.swift
//  RickAndMorty
//
//  Created by aleksandre on 25.05.22.
//

import Foundation


protocol CharacterServicable
{
    func getSelectedCharacters(selectedIDs: String) async -> Result<Character.NetworkResponse, RequestError>
}


struct CharacterService: NetworkEngine, CharacterServicable
{
    func getSelectedCharacters(selectedIDs: String) async -> Result<Character.NetworkResponse, RequestError> {
        return await sendRequest(endpoint: RickAndMortyEndpoint.getSelectedCharacters(IDs: selectedIDs), responseModel: Character.NetworkResponse.self)
    }
    
    
}
