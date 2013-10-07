package org.stevegood.sk



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RaidMemberController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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
