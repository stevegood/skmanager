package org.stevegood

import org.stevegood.sec.User

class DashboardController {

    def raidService
    def springSecurityService

    def index() {
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def ownedRaidList = raidService.myOwnedRaids(currentUser)
        def managedRaidList = raidService.myManagedRaids(currentUser)
        [ownedRaidList: ownedRaidList, managedRaidList: managedRaidList]
    }
}
