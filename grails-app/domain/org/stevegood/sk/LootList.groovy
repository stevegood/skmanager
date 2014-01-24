package org.stevegood.sk

import org.stevegood.game.PlayerCharacter

class LootList {

    String name

    static belongsTo = [raid:Raid]

    static constraints = {
        raid unique: ['name']
    }

    def getMembers() {
        RaidMember.findAllByLootList(this)?.sort { it.listPosition } ?: []
    }

    def addPlayerCharacter(PlayerCharacter character, boolean substitute=false, boolean onLeave=false) {
        RaidMember.create(this, character, substitute, onLeave)
    }

    int getMemberCount(){
        RaidMember.countByLootListAndSubstitute(this, false)
    }

    int getSubstituteCount() {
        RaidMember.countByLootListAndSubstitute(this, true)
    }
}
