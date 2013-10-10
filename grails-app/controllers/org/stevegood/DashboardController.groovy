package org.stevegood

import org.stevegood.sec.User
import org.stevegood.sk.Raid

class DashboardController {

    def springSecurityService

    def index() {
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def raidList = Raid.findAllByOwner(currentUser)
        [raidList: raidList]
    }
}
