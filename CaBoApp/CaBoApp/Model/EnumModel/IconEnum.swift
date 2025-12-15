//
//  IconEnum.swift
//  CaBoApp
//
//  Created by vadym vasylaki on 10.12.2025.
//

import Foundation

enum IconEnum: String {
    case onboardingImg1, onboardingImg2, onboardingImg3, placeButton, settings, homeSessionsButton, cultureLessonsButton, cocktailsButton, startSessionImg, favIconOff, favIconOn,
         backBtn
    case caribbeanStormPunch, cubaLibreOrigins, cubanClassicsDaiquiri, havanaSunriseSpritz, malecónMojitoNight, islandBreezeCooler//coctail
    case buenaNocheTerrace, caféCubanoRitual, cigarLoungeAtmosphere, colonialRomanceTales, courtyardFiesta, dominoTableTales, havanaHomeBarSetup, paladarDinnerVibes, rumBasicsTraditions, rumLibraryBeginner, sugarcanesSeaSalt, tropicanaDreamLights//culture
    case balconySunsetRitual, buenaNocheHomeSession, caféCubanoattheKitchenTable, cigarLoungeatHome, cubanNightatHome, eveningDominoRitual, homeBarHavanaStyle, kitchenFiestaSetup, rumsStorytellingNight, terraceCandlelightSession//homesession
    case cubanHomeKitchenIntro, havanaRooftopChill, malecónLoversBench, malecónSunsetStory, midnightonObispoStreet, nightUnderHavanaStars, oldChevyCityDrive, oldHavanaWalkthrough, plazaViejaEveningWalk, streetCarnivalVibes, streetMarketStories, vedadoVintageBars
    
    var icon: String {
        return self.rawValue
    }
}
