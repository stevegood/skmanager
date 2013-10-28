package org.stevegood.game

import grails.transaction.Transactional

@Transactional
class PlayerCharacterService {

    def processCharacterData(characterData) {
        def characters = []
        def charactersUpdated = 0
        def charactersAdded = 0
        def charactersIgnored = 0
        characterData.each {
            def pc = PlayerCharacter.findOrCreateByName(it.name as String)
            characters << pc
            def characterClass = CharacterClass.findOrCreateByName(it.characterClass as String).save(flush: true)

            if (!pc.id) {
                pc.note = it.note
                charactersAdded++
            } else {
                if (pc.level != it.level || pc.characterClass != characterClass) {
                    charactersUpdated++
                } else {
                    charactersIgnored++
                }
            }

            pc.characterClass = characterClass
            pc.level = it.level

            if (pc.isDirty() || !pc.id) {
                pc.save()
            }
        }

        [charactersUpdated: charactersUpdated, charactersAdded: charactersAdded, charactersIgnored: charactersIgnored, characters: characters]
    }
}
