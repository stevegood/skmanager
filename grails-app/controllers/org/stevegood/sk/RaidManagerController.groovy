package org.stevegood.sk

import org.stevegood.sec.User

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RaidManagerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [raidManagerInstanceCount: RaidManager.count(), raidManagerInstanceList: RaidManager.list(params)]
    }

    def show(RaidManager raidManagerInstance) {
        [raidManagerInstance: raidManagerInstance]
    }

    def create() {
        Raid raid = params.raid =  Raid.get(params.int('raid.id'))
        def users = User.withCriteria {
            ne 'id', raid.owner.id
            raid.managers?.each {
                ne 'id', it.id
            }

        }
        [raidManagerInstance: new RaidManager(params), users: users]
    }

    @Transactional
    def save(RaidManager raidManagerInstance) {
        if (raidManagerInstance == null) {
            notFound()
            return
        }

        if (raidManagerInstance.hasErrors()) {
            render view:'create', model: [raidManagerInstance: raidManagerInstance]
            return
        }

        raidManagerInstance.save flush:true

        flash.message = "${raidManagerInstance.manager.username} has been added as a manager to ${raidManagerInstance.raid.name}"
        redirect controller: 'raid', action: 'show', id: raidManagerInstance.raid.id
    }

    def edit(RaidManager raidManagerInstance) {
        respond raidManagerInstance
    }

    @Transactional
    def update(RaidManager raidManagerInstance) {
        if (raidManagerInstance == null) {
            notFound()
            return
        }

        if (raidManagerInstance.hasErrors()) {
            respond raidManagerInstance.errors, view:'edit'
            return
        }

        raidManagerInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'RaidManager.label', default: 'RaidManager'), raidManagerInstance.id])
                redirect raidManagerInstance
            }
            '*'{ respond raidManagerInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(RaidManager raidManagerInstance) {

        if (raidManagerInstance == null) {
            notFound()
            return
        }

        raidManagerInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'RaidManager.label', default: 'RaidManager'), raidManagerInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'raidManagerInstance.label', default: 'RaidManager'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
