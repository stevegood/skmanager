package org.stevegood

import org.stevegood.game.PlayerCharacter
import org.stevegood.sec.User
import org.stevegood.sk.Raid
import org.stevegood.sk.RaidMember

class AdminController {

    def index() {
        def userCount = User.count()
        def characterCount = PlayerCharacter.count()
        def raidCount = Raid.count()
        def charactersInRaids = RaidMember.list().collect { it.character }.unique().size()

        [userCount: userCount, characterCount: characterCount, raidCount: raidCount, charactersInRaids: charactersInRaids]
    }
}
