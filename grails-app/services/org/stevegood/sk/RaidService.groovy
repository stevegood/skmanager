package org.stevegood.sk

import grails.transaction.Transactional
import org.stevegood.sec.User

@Transactional
class RaidService {

    def myRaids(User user) {
        Raid.findAllByOwner(user)
    }

    void compressMembers(Raid raid) {
        def i = 0
        raid.members.sort { it.listPosition }.each { raidMember ->
            if (!raidMember.substitute) {
                raidMember?.listPosition = i
                raidMember?.save(flush: true)
                i++
            }
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
}
