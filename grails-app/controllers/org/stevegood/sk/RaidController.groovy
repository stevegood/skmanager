package org.stevegood.sk

import grails.converters.JSON
import org.stevegood.game.CharacterClass
import org.stevegood.game.PlayerCharacter
import org.stevegood.sec.User
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RaidController {

    static allowedMethods = [save: "POST", update: "PUT"]

    def raidService
    def riftService
    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [raidInstanceCount: Raid.count(), raidInstanceList: Raid.list(params)]
    }

    def mine(){
        def currentUser = User.findByUsername(springSecurityService.currentUser.username as String)
        [raidInstanceList: raidService.myOwnedRaids(currentUser)]
    }

    def show(Raid raidInstance) {
        if (!raidInstance || (raidInstance.hidden && (raidInstance.owner.username != springSecurityService.currentUser.username || sec.ifAllGranted(roles: ['ROLE_ADMIN'])))) {
            flash.message = "You are not premitted to view that Raid."
            redirect controller: 'dashboard', action: 'index'
            return
        }

        [raidInstance: raidInstance]
    }

    def create() {
        [raidInstance: new Raid(params)]
    }

    @Transactional
    def save(Raid raidInstance) {
        if (raidInstance == null) {
            notFound()
            return
        }

        User currentUser = User.findByUsername(springSecurityService.currentUser.username)
        raidInstance.owner = currentUser

        if (raidInstance.hasErrors()) {
            flash.message = 'Please correct the errors below'
            render view:'create', model: [raidInstance: raidInstance]
            return
        }

        raidInstance.save flush:true

        flash.message = "${raidInstance.name} created!"
        redirect raidInstance
    }

    def edit(Raid raidInstance) {
        [raidInstance: raidInstance]
    }

    @Transactional
    def update(Raid raidInstance) {
        if (raidInstance == null) {
            notFound()
            return
        }

        if (raidInstance.hasErrors()) {
            flash.message = 'Please correct the errors below'
            render view:'create', model: [raidInstance: raidInstance]
            return
        }

        raidInstance.save flush:true

        flash.message = "${raidInstance.name} updated!"
        redirect raidInstance
    }

    @Transactional
    def delete(Raid raidInstance) {

        if (raidInstance == null) {
            notFound()
            return
        }

        // delete the raid member relationships first
        raidInstance.members*.delete flush: true
        raidInstance.delete flush:true

        flash.message = "${raidInstance.name} deleted!"
        redirect action:"index", method:"GET"
    }

    @Transactional
    def addCharacter() {
        def pc = PlayerCharacter.get(params.pc_id)
        def list = LootList.get(params.list_id)
        def raidMember = list.addPlayerCharacter(pc)
        raidMember.note = params.note
        raidMember.substitute = params?.boolean('substitute')
        render raidMember as JSON
    }

    @Transactional
    def importRaidString() {
        def raidInstance = Raid.get(params.id as long)
        if (raidInstance.name.toLowerCase() != params.importString.split(':=')[0].toLowerCase()) {
            flash.message = "Raid string does not appear to be for this raid!"
            flash.type = 'danger'
        } else {
            // import the raid string data
            raidService.parseRaidString(params.importString.toString()).each {
                PlayerCharacter pc = PlayerCharacter.findByName(it.name as String)
                RaidMember raidMember = RaidMember.findByRaidAndCharacter(raidInstance, pc)

                raidMember.listPosition = it.listPosition as int
                raidMember.save()
            }
        }
        redirect action: 'show', id: raidInstance.id
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'raidInstance.label', default: 'Raid'), params.id])
        redirect action: "index", method: "GET"
    }
}
