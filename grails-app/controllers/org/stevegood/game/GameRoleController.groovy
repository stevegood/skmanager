package org.stevegood.game



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GameRoleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond GameRole.list(params), model:[gameRoleInstanceCount: GameRole.count()]
    }

    def show(GameRole gameRoleInstance) {
        respond gameRoleInstance
    }

    def create() {
        respond new GameRole(params)
    }

    @Transactional
    def save(GameRole gameRoleInstance) {
        if (gameRoleInstance == null) {
            notFound()
            return
        }

        if (gameRoleInstance.hasErrors()) {
            respond gameRoleInstance.errors, view:'create'
            return
        }

        gameRoleInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'gameRoleInstance.label', default: 'GameRole'), gameRoleInstance.id])
                redirect gameRoleInstance
            }
            '*' { respond gameRoleInstance, [status: CREATED] }
        }
    }

    def edit(GameRole gameRoleInstance) {
        respond gameRoleInstance
    }

    @Transactional
    def update(GameRole gameRoleInstance) {
        if (gameRoleInstance == null) {
            notFound()
            return
        }

        if (gameRoleInstance.hasErrors()) {
            respond gameRoleInstance.errors, view:'edit'
            return
        }

        gameRoleInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'GameRole.label', default: 'GameRole'), gameRoleInstance.id])
                redirect gameRoleInstance
            }
            '*'{ respond gameRoleInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(GameRole gameRoleInstance) {

        if (gameRoleInstance == null) {
            notFound()
            return
        }

        gameRoleInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'GameRole.label', default: 'GameRole'), gameRoleInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'gameRoleInstance.label', default: 'GameRole'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
