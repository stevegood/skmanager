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

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Raid.list(params), model:[raidInstanceCount: Raid.count()]
    }

    def show(Raid raidInstance) {
        if (!raidInstance || (raidInstance.hidden && (raidInstance.owner.username != springSecurityService.currentUser.username || sec.ifAllGranted(roles: ['ROLE_ADMIN'])))) {
            flash.message = "You are not premitted to view that Raid."
            redirect controller: 'dashboard', action: 'index'
            return
        }

        def characterClasses = CharacterClass.list()
        def colWidth = characterClasses.size() ? 12 / characterClasses.size() : 0

        [raidInstance: raidInstance, characterClasses: characterClasses, colWidth: colWidth]
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
            respond raidInstance.errors, view:'create'
            return
        }

        raidInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'raidInstance.label', default: 'Raid'), raidInstance.id])
                redirect raidInstance
            }
            '*' { respond raidInstance, [status: CREATED] }
        }
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
            respond raidInstance.errors, view:'edit'
            return
        }

        raidInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Raid.label', default: 'Raid'), raidInstance.id])
                redirect raidInstance
            }
            '*'{ respond raidInstance, [status: OK] }
        }
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

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Raid.label', default: 'Raid'), raidInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def addCharacter() {
        def pc = PlayerCharacter.get(params.pc_id)
        def raid = Raid.get(params.raid_id)
        def raidMember = raid.addPlayerCharacter(pc)
        raidMember.note = params.note
        render raidMember as JSON
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'raidInstance.label', default: 'Raid'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
