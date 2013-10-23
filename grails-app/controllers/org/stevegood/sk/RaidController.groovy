package org.stevegood.sk

import grails.converters.JSON
import org.stevegood.game.CharacterClass
import org.stevegood.game.PlayerCharacter
import org.stevegood.sec.User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RaidController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def raidService
    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [raidInstanceCount: Raid.count(), raidInstanceList: Raid.list(params)]
    }

    def mine(){
        def currentUser = User.findByUsername(springSecurityService.currentUser.username as String)
        [raidInstanceList: raidService.myRaids(currentUser)]
    }

    def show(Raid raidInstance) {
        if (!raidInstance || (raidInstance.hidden && (raidInstance.owner.username != springSecurityService.currentUser.username || sec.ifAllGranted(roles: ['ROLE_ADMIN'])))) {
            flash.message = "You are not premitted to view that Raid."
            redirect controller: 'dashboard', action: 'index'
            return
        }

        def characterClasses = CharacterClass.list()
        def colWidth = characterClasses.size() ? 12 / characterClasses.size() : 0

        def raidMembersByClass = []
        def raidMembers = raidInstance.members
        characterClasses.each { CharacterClass _class ->
            def classMap = [characterClass: _class, members: [], subs: []]
            raidMembers.findAll { it.character.characterClass == _class }?.each { RaidMember raidMember ->
                println "${raidMember.character.name} :: ${raidMember.substitute}"
                classMap[raidMember.substitute ? 'subs' : 'members'] << raidMember
            }
            raidMembersByClass << classMap
        }

        println raidMembersByClass
        [raidInstance: raidInstance, characterClasses: characterClasses, colWidth: colWidth, raidMembersByClass: raidMembersByClass]
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
        println params
        def pc = PlayerCharacter.get(params.pc_id)
        def raid = Raid.get(params.raid_id)
        def raidMember = raid.addPlayerCharacter(pc)
        raidMember.note = params.note
        raidMember.substitute = params?.boolean('substitute')
        render raidMember as JSON
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'raidInstance.label', default: 'Raid'), params.id])
        redirect action: "index", method: "GET"
    }
}
