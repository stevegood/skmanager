package org.stevegood.sk

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import org.stevegood.sec.User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RaidMemberController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def raidService
    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [raidMemberInstanceCount: RaidMember.count(), raidMemberInstanceList: RaidMember.list(params)]
    }

    def show(RaidMember raidMemberInstance) {
        [raidMemberInstance: raidMemberInstance]
    }

    def create() {
        [raidMemberInstance: new RaidMember(params)]
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

    @Transactional
    def removeFromRaid() {
        def raidMember = RaidMember.get(params.raid_member_id)
        def raid = raidMember.raid
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!(currentUser == raid?.owner || raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        raidMember.delete(flush: true)

        redirect controller: 'raid', action: 'show', id: raid.id
        return
    }

    @Transactional
    def repositionMembers() {
        def raid = Raid.get(params.getInt('raid_id'))
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!raid || !(currentUser == raid?.owner || raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        def ids = params.raid_member_ids.split(',')
        println ids
        def result = [ids: raidService.repositionById(ids).collect { it.id }]
        render result as JSON
        return
    }

    @Transactional
    def makeSubstitute() {
        def raidMember = RaidMember.get(params.raid_member_id)
        def raid = raidMember?.raid
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!raid || !(currentUser == raid?.owner || raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        raidMember.substitute = true
        raidMember.listPosition = raidMember.raid.substituteCount
        raidMember.save(flush: true)

        raidService.compressMembers(raid)

        flash.message = "${raidMember.character.name} has been moved to the substitute list"

        redirect controller: 'raid', action: 'show', id: raid.id
        return
    }

    @Transactional
    def makeCore() {
        def raidMember = RaidMember.get(params.raid_member_id)
        def raid = raidMember?.raid
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!raid || !(currentUser == raid?.owner || raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        raidMember.substitute = false
        raidMember.listPosition = raidMember.raid.memberCount
        raidMember.save(flush: true)

        flash.message = "${raidMember.character.name} has been moved to the core list"

        redirect controller: 'raid', action: 'show', id: raid.id
        return
    }

    @Transactional
    def makeSubTempActive() {
        def raidMember = RaidMember.get(params.raid_member_id)
        def raid = raidMember?.raid
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!raid || !(currentUser == raid?.owner || raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        def listSize = raid.members.findAll { it.character.characterClass == raidMember.character.characterClass && !it.substitute }.size()
        raidMember.listPosition = listSize
        raidMember.tempActive = true
        raidMember.save(flush: true)

        redirect controller: 'raid', action: 'show', id: raid.id
        return
    }

    @Transactional
    def removeTempActiveSub() {
        // TODO: make sub tempActive = false

        def raidMember = RaidMember.get(params.raid_member_id)
        def raid = raidMember?.raid
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!raid || !(currentUser == raid?.owner || raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        def subs = RaidMember.withCriteria {
            eq 'raid', raid
            eq 'substitute', true
            or {
                isNull 'tempActive'
                eq 'tempActive', false
            }
            character {
                eq 'characterClass', raidMember.character.characterClass
            }
        }
        raidMember.tempActive = false
        raidMember.save(flush: true)

        def ids = subs.collect { it.id } + raidMember.id
        raidService.repositionById(ids)

        redirect controller: 'raid', action: 'show', id: raid.id
        return
    }

    @Transactional
    def deactivateAllTempActive() {
        def raid = Raid.get(params.getInt('id'))
        def currentUser = User.findByUsername(springSecurityService.currentUser.username)
        def isAdmin = SpringSecurityUtils.ifAllGranted('ROLE_ADMIN')

        if (!raid || !(currentUser == raid?.owner || raid?.managers?.contains(currentUser) || isAdmin)) {
            notFound()
            return
        }

        raidService.clearTempActiveSubs(raid)

        redirect controller: 'raid', action: 'show', id: raid.id
        return
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'raidMemberInstance.label', default: 'RaidMember'), params.id])
        redirect action: "index", method: "GET"
    }
}
