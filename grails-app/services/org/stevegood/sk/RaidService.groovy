package org.stevegood.sk

import grails.transaction.Transactional
import org.stevegood.game.CharacterClass
import org.stevegood.sec.User

@Transactional
class RaidService {

    def myOwnedRaids(User user) {
        Raid.findAllByOwner(user)
    }

    def myManagedRaids(User user) {
        RaidManager.findAllByManager(user)?.collect { it.raid } ?: []
    }

    void compressMembers(Raid raid) {
        def i = 0
        def raidMembers = RaidMember.withCriteria {
            eq 'raid', raid
            or {
                and {
                    eq 'substitute', true
                    eq 'tempActive', true
                }
                eq 'substitute', false
            }
        }

        CharacterClass.list().each { charClass ->
            raidMembers.findAll { it.character.characterClass == charClass }.sort { it.listPosition }.each { raidMember ->
                raidMember?.listPosition = i
                raidMember?.save(flush: true)
                i++
            }
            i = 0
        }
    }

    def repositionById(def ids) {
        def members = []
        ids.eachWithIndex { id, i ->
            def member = RaidMember.get(id)
            member.listPosition = i
            member.save()
            members << member
        }
        return members
    }

    void clearTempActiveSubs(Raid raid) {
        def activeSubs = RaidMember.findAllBySubstituteAndTempActiveAndRaid(true, true, raid)
        activeSubs*.setTempActive(false)
        activeSubs*.save(flush: true)

        compressMembers(raid)
    }
}
