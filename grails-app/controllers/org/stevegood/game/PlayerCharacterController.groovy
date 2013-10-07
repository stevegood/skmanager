package org.stevegood.game



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PlayerCharacterController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PlayerCharacter.list(params), model:[playerCharacterInstanceCount: PlayerCharacter.count()]
    }

    def show(PlayerCharacter playerCharacterInstance) {
        respond playerCharacterInstance
    }

    def create() {
        respond new PlayerCharacter(params)
    }

    @Transactional
    def save(PlayerCharacter playerCharacterInstance) {
        if (playerCharacterInstance == null) {
            notFound()
            return
        }

        if (playerCharacterInstance.hasErrors()) {
            respond playerCharacterInstance.errors, view:'create'
            return
        }

        playerCharacterInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'playerCharacterInstance.label', default: 'PlayerCharacter'), playerCharacterInstance.id])
                redirect playerCharacterInstance
            }
            '*' { respond playerCharacterInstance, [status: CREATED] }
        }
    }

    def edit(PlayerCharacter playerCharacterInstance) {
        respond playerCharacterInstance
    }

    @Transactional
    def update(PlayerCharacter playerCharacterInstance) {
        if (playerCharacterInstance == null) {
            notFound()
            return
        }

        if (playerCharacterInstance.hasErrors()) {
            respond playerCharacterInstance.errors, view:'edit'
            return
        }

        playerCharacterInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PlayerCharacter.label', default: 'PlayerCharacter'), playerCharacterInstance.id])
                redirect playerCharacterInstance
            }
            '*'{ respond playerCharacterInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PlayerCharacter playerCharacterInstance) {

        if (playerCharacterInstance == null) {
            notFound()
            return
        }

        playerCharacterInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PlayerCharacter.label', default: 'PlayerCharacter'), playerCharacterInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'playerCharacterInstance.label', default: 'PlayerCharacter'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
