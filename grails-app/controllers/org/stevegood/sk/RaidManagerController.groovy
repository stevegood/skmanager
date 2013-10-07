package org.stevegood.sk



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RaidManagerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond RaidManager.list(params), model:[raidManagerInstanceCount: RaidManager.count()]
    }

    def show(RaidManager raidManagerInstance) {
        respond raidManagerInstance
    }

    def create() {
        respond new RaidManager(params)
    }

    @Transactional
    def save(RaidManager raidManagerInstance) {
        if (raidManagerInstance == null) {
            notFound()
            return
        }

        if (raidManagerInstance.hasErrors()) {
            respond raidManagerInstance.errors, view:'create'
            return
        }

        raidManagerInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'raidManagerInstance.label', default: 'RaidManager'), raidManagerInstance.id])
                redirect raidManagerInstance
            }
            '*' { respond raidManagerInstance, [status: CREATED] }
        }
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
