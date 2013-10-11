package org.stevegood.sk

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import org.stevegood.sec.User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RaidMemberController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond RaidMember.list(params), model:[raidMemberInstanceCount: RaidMember.count()]
    }

    def show(RaidMember raidMemberInstance) {
        respond raidMemberInstance
    }

    def create() {
        respond new RaidMember(params)
    }

    @Transactional
    def save(RaidMember raidMemberInstance) {
        if (raidMemberInstance == null) {
            notFound()
            return
        }

        if (raidMemberInstance.hasErrors()) {
            respond raidMemberInstance.errors, view:'create'
            return
        }

        raidMemberInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'raidMemberInstance.label', default: 'RaidMember'), raidMemberInstance.id])
                redirect raidMemberInstance
            }
            '*' { respond raidMemberInstance, [status: CREATED] }
        }
    }

    def edit(RaidMember raidMemberInstance) {
        respond raidMemberInstance
    }

    @Transactional
    def update(RaidMember raidMemberInstance) {
        if (raidMemberInstance == null) {
            notFound()
            return
        }

        if (raidMemberInstance.hasErrors()) {
            respond raidMemberInstance.errors, view:'edit'
            return
        }

        raidMemberInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'RaidMember.label', default: 'RaidMember'), raidMemberInstance.id])
                redirect raidMemberInstance
            }
            '*'{ respond raidMemberInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(RaidMember raidMemberInstance) {

        if (raidMemberInstance == null) {
            notFound()
            return
        }

        raidMemberInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'RaidMember.label', default: 'RaidMember'), raidMemberInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    @Transactional
    def moveToBottom() {
        def raidMember = RaidMember.get(params.raid_member_id)
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!(currentUser == raidMember?.raid?.owner || raidMember?.raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        def classList = []
        raidMember.raid.members.sort { it.listPosition }.each {
            // collect all the members of the same class except the member about to be placed at the bottom
            if (it.character.characterClass == raidMember.character.characterClass && raidMember != it) {
                it.listPosition = classList.size()
                it.save()
                classList << it
            }
        }
        raidMember.listPosition = classList.size()
        raidMember.save()

        redirect controller: 'raid', action: 'show', id: raidMember.raid.id
        return
    }

    def removeFromRaid() {
        def raidMember = RaidMember.get(params.raid_member_id)
        def raid = raidMember.raid
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!(currentUser == raidMember?.raid?.owner || raidMember?.raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        raidMember.delete(flush: true)

        redirect controller: 'raid', action: 'show', id: raid.id
        return
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'raidMemberInstance.label', default: 'RaidMember'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
