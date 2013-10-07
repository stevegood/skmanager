package org.stevegood.sk

import org.stevegood.sec.User

class RaidManager {

    Date dateCreated
    Date lastUpdated

    Raid raid
    User manager

    static constraints = {
        raid unique: ['manager']
    }

    static RaidManager create(Raid raid, User manager) {
        RaidManager.findOrCreateByRaidAndManager(raid, manager).save(flush: true)
    }
}
