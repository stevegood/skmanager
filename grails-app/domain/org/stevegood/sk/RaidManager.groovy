package org.stevegood.sk

import org.stevegood.sec.User

class RaidManager {

    static auditable = true
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
