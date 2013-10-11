package org.stevegood.sk

import org.stevegood.game.PlayerCharacter

class RaidMember {

    Date dateCreated
    Date lastUpdated

    Raid raid
    PlayerCharacter character
    boolean substitute = false
    boolean onLeave = false
    int listPosition
    String note

    static constraints = {
        note nullable: true, blank: true
        raid unique: ['character']
        listPosition nullable: false
    }

    static mapping = {
        note type: 'text'
    }

    static RaidMember create(Raid raid, PlayerCharacter character, boolean substitute=false, boolean onLeave=false) {
        RaidMember raidMember = RaidMember.findOrCreateByRaidAndCharacter(raid, character)
        raidMember.substitute = substitute
        raidMember.onLeave = onLeave
        def characterClassCount = 0
        raid.members.each {
            if (it.character.characterClass == character.characterClass) {
                characterClassCount++
            }
        }
        raidMember.listPosition = characterClassCount
        raidMember.save(flush: true)
    }
}
