package org.stevegood.sk

import org.stevegood.game.PlayerCharacter
import org.stevegood.sec.User

class Raid {

    static transients = ['members', 'managers']

    Date dateCreated
    Date lastUpdated

    String name
    boolean hidden = false

    static belongsTo = [owner:User]

    static constraints = {
        owner unique: ['name']
    }

    static mapping = {
        sort 'name'
    }

    String toString() {
        name
    }

    List<User> getManagers() {
        RaidManager.findAllByRaid(this)?.collect { it.manager } ?: []
    }

    def addManager(User manager) {
        if (manager != owner) {
            RaidManager.create(this, manager)
        }
    }

    def removeManager(User manager) {
        RaidManager.findByRaidAndManager(this, manager)?.delete(flush: true)
    }

    static List<Raid> findAllByManager(User manager) {
        RaidManager.findAllByManager(manager)?.collect { it.raid } ?: []
    }

    List<RaidMember> getMembers() {
        RaidMember.findAllByRaid(this) ?: []
    }

    def addMember(PlayerCharacter character, boolean substitute=false, boolean onLeave=false) {
            RaidMember.create(this, character, substitute, onLeave)
    }

    def removeMember(PlayerCharacter character) {
        RaidMember.findByRaidAndCharacter(this, character)?.delete(flush: true)
    }

    static List<Raid> findAllByMember(PlayerCharacter character) {
        RaidMember.findAllByCharacter(character)?.collect { it.raid } ?: []
    }
}
