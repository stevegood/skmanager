package org.stevegood

import org.stevegood.sec.User
import org.stevegood.sk.Raid

class DashboardController {

    def raidService
    def springSecurityService

    def index() {
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def raidList = raidService.myRaids(currentUser)
        [raidList: raidList]
    }
}
