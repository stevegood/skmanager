package org.stevegood.sk

import org.stevegood.game.CharacterClass
import org.stevegood.game.PlayerCharacter
import org.stevegood.sec.User

class Raid {

    static auditable = true
    static transients = ['members', 'managers', 'memberCount', 'substituteCount']

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

//    List<RaidMember> getMembers() {
//        RaidMember.findAllByRaid(this) ?: []
//    }

//    def addPlayerCharacter(PlayerCharacter character, boolean substitute=false, boolean onLeave=false) {
//            RaidMember.create(this, character, substitute, onLeave)
//    }

//    def removePlayerCharacter(PlayerCharacter character) {
//        RaidMember.findByRaidAndCharacter(this, character)?.delete(flush: true)
//    }

//    static List<Raid> findAllByMember(PlayerCharacter character) {
//        RaidMember.findAllByCharacter(character)?.collect { it.raid } ?: []
//    }

//    int getMemberCount(){
//        RaidMember.countByRaidAndSubstitute(this, false)
//    }

//    int getSubstituteCount() {
//        RaidMember.countByRaidAndSubstitute(this, true)
//    }

    boolean isManager(String username) {
        (managers?.findAll { it?.username == username }?.size() ?: 0) > 0
    }

    String toString() {
        name
    }

    String toRaidString(){
        String str
        // recurse and build the raid as a string
        /*
         * SAMPLE STRING:
         * Test Raid:=Cleric:@Dalston:!level::60!!listPosition::0,Terela:!level::60!!listPosition::1:#Mage:@Knopix:!level::60!!listPosition::0
         */
        str = "$name:="
        def callingStrs = []
        CharacterClass.list(sort: 'name', order: 'asc')?.each { calling ->

            def raidMemberStrs = []
            RaidMember.withCriteria {
                eq 'raid', this
                character {
                    eq 'characterClass', calling
                }
                or {
                    eq 'substitute', false
                    and {
                        eq 'substitute', true
                        eq 'tempActive', true
                    }
                }
                order 'listPosition', 'asc'
            }?.each { raidMember ->
                raidMemberStrs << "${raidMember.character.name}:!level::${raidMember.character.level}!!listPosition::${raidMember.listPosition}!!substitute::${raidMember.substitute}"
            }

            callingStrs << "${calling.name}:@${raidMemberStrs.join(',')}"
        }

        str += callingStrs.join(':#')

        return str
    }
}
