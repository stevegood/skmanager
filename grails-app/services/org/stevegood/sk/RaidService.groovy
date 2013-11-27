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

    def parseRaidString(String raidString) {
        def characterData = []
        String raidStringData = raidString.split(':=')[1]
        def callingsData = raidStringData.split(':#')
        callingsData.each { String cd ->
            def callingParts = cd.split(':@')
            String callingData = callingParts[1]

            callingData.split(',').each { String d ->
                def data = d.split(':!')
                String characterName = data[0]
                String characterDataString = data[1]

                def map = [name: characterName]
                characterDataString.split('!!').each {
                    def propData = it.split('::')
                    map[propData[0]] = propData[1]
                }
                characterData << map
            }
        }

        return characterData
    }
}
