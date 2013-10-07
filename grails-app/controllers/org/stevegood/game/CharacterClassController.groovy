package org.stevegood.game



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CharacterClassController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CharacterClass.list(params), model:[characterClassInstanceCount: CharacterClass.count()]
    }

    def show(CharacterClass characterClassInstance) {
        respond characterClassInstance
    }

    def create() {
        respond new CharacterClass(params)
    }

    @Transactional
    def save(CharacterClass characterClassInstance) {
        if (characterClassInstance == null) {
            notFound()
            return
        }

        if (characterClassInstance.hasErrors()) {
            respond characterClassInstance.errors, view:'create'
            return
        }

        characterClassInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'characterClassInstance.label', default: 'CharacterClass'), characterClassInstance.id])
                redirect characterClassInstance
            }
            '*' { respond characterClassInstance, [status: CREATED] }
        }
    }

    def edit(CharacterClass characterClassInstance) {
        respond characterClassInstance
    }

    @Transactional
    def update(CharacterClass characterClassInstance) {
        if (characterClassInstance == null) {
            notFound()
            return
        }

        if (characterClassInstance.hasErrors()) {
            respond characterClassInstance.errors, view:'edit'
            return
        }

        characterClassInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CharacterClass.label', default: 'CharacterClass'), characterClassInstance.id])
                redirect characterClassInstance
            }
            '*'{ respond characterClassInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CharacterClass characterClassInstance) {

        if (characterClassInstance == null) {
            notFound()
            return
        }

        characterClassInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CharacterClass.label', default: 'CharacterClass'), characterClassInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'characterClassInstance.label', default: 'CharacterClass'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
