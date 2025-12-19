
import Foundation

enum IconEnum: String {
    case onboardingImg1, onboardingImg2, onboardingImg3, placeButton, settings, homeSessionsButton, cultureLessonsButton, cocktailsButton, startSessionImg, favIconOff, favIconOn,
         backBtn, ingredientIcon, cocktailListImage, componentUnitFacts, componentUnitOrigin, componentUnitStory, cultureReflect, culturePrepare, cultureMix, cultureListen, searchFieldIcon, starDifficulty1Enum, timeNeededIcon, deleteIcon, searchResultsIcon, trashIcon, journalFavIcon, lockIcon, lockIconSmall, aboutAppIcon, resetIcon, caboLogo, offlinePhone, exportDataIcon, laterIcon, rotationIndicator, previewBackground
    case favoritesCategory, historyCategory, homeCategory, searchCategory, statCategory
    case caribbeanStormPunch, cubaLibreOrigins, cubanClassicsDaiquiri, havanaSunriseSpritz, malecónMojitoNight, islandBreezeCooler//coctail
    case buenaNocheTerrace, caféCubanoRitual, cigarLoungeAtmosphere, colonialRomanceTales, courtyardFiesta, dominoTableTales, havanaHomeBarSetup, paladarDinnerVibes, rumBasicsTraditions, rumLibraryBeginner, sugarcaneSeaSalt, tropicanaDreamLights//culture
    case balconySunsetRitual, buenaNocheHomeSession, caféCubanoattheKitchenTable, cigarLoungeatHome, cubanNightatHome, eveningDominoRitual, homeBarHavanaStyle, kitchenFiestaSetup, rumStorytellingNight, terraceCandlelightSession//homesession
    case cubanHomeKitchenIntro, havanaRooftopChill, malecónLoversBench, malecónSunsetStory, midnightonObispoStreet, nightUnderHavanaStars, oldChevyCityDrive, oldHavanaWalkthrough, plazaViejaEveningWalk, streetCarnivalVibes, streetMarketStories, vedadoVintageBars
    
    var icon: String {
        return self.rawValue
    }
}
