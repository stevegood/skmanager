package org.stevegood.sk

import org.stevegood.game.PlayerCharacter

class RaidMember {

    static auditable = true

    Date dateCreated
    Date lastUpdated

    LootList lootList
    PlayerCharacter character
    boolean substitute = false
    boolean onLeave = false
    boolean tempActive = false
    int listPosition
    String note

    static constraints = {
        note nullable: true, blank: true
        lootList unique: ['character']
        listPosition nullable: false
        tempActive nullable: true
    }

    static mapping = {
        note type: 'text'
    }

    static RaidMember create(LootList lootList, PlayerCharacter character, boolean substitute=false, boolean onLeave=false) {
        def listMembersCount = RaidMember.countByLootList(lootList)
        if (listMembersCount > 0) {
            listMembersCount++
        }
        RaidMember raidMember = RaidMember.findOrCreateByLootListAndCharacter(lootList, character)
        raidMember.substitute = substitute
        raidMember.onLeave = onLeave
        raidMember.listPosition = listMembersCount
        raidMember.save(flush: true)
    }

    String toString() {
        "${character.name}"
    }
}
