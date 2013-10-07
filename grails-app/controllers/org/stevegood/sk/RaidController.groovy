package org.stevegood.sk



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RaidController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Raid.list(params), model:[raidInstanceCount: Raid.count()]
    }

    def show(Raid raidInstance) {
        respond raidInstance
    }

    def create() {
        respond new Raid(params)
    }

    @Transactional
    def save(Raid raidInstance) {
        if (raidInstance == null) {
            notFound()
            return
        }

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
        respond raidInstance
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

        raidInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Raid.label', default: 'Raid'), raidInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
