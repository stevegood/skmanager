package org.stevegood.game



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CharacterRoleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond CharacterRole.list(params), model:[characterRoleInstanceCount: CharacterRole.count()]
    }

    def show(CharacterRole characterRoleInstance) {
        respond characterRoleInstance
    }

    def create() {
        respond new CharacterRole(params)
    }

    @Transactional
    def save(CharacterRole characterRoleInstance) {
        if (characterRoleInstance == null) {
            notFound()
            return
        }

        if (characterRoleInstance.hasErrors()) {
            respond characterRoleInstance.errors, view:'create'
            return
        }

        characterRoleInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.created.message', args: [message(code: 'characterRoleInstance.label', default: 'CharacterRole'), characterRoleInstance.id])
                redirect characterRoleInstance
            }
            '*' { respond characterRoleInstance, [status: CREATED] }
        }
    }

    def edit(CharacterRole characterRoleInstance) {
        respond characterRoleInstance
    }

    @Transactional
    def update(CharacterRole characterRoleInstance) {
        if (characterRoleInstance == null) {
            notFound()
            return
        }

        if (characterRoleInstance.hasErrors()) {
            respond characterRoleInstance.errors, view:'edit'
            return
        }

        characterRoleInstance.save flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'CharacterRole.label', default: 'CharacterRole'), characterRoleInstance.id])
                redirect characterRoleInstance
            }
            '*'{ respond characterRoleInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(CharacterRole characterRoleInstance) {

        if (characterRoleInstance == null) {
            notFound()
            return
        }

        characterRoleInstance.delete flush:true

        request.withFormat {
            form {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'CharacterRole.label', default: 'CharacterRole'), characterRoleInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'characterRoleInstance.label', default: 'CharacterRole'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
