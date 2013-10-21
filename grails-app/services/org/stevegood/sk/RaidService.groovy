package org.stevegood.sk

import grails.transaction.Transactional
import org.stevegood.sec.User

@Transactional
class RaidService {

    def myRaids(User user) {
        Raid.findAllByOwner(user)
    }
}
