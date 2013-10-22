package org.stevegood.game



import grails.transaction.Transactional

@Transactional(readOnly = true)
class CharacterClassController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [characterClassInstanceCount: CharacterClass.count(), characterClassInstanceList: CharacterClass.list(params)]
    }

    def show(CharacterClass characterClassInstance) {
        [characterClassInstance: characterClassInstance]
    }

    def create() {
        [characterClassInstance: new CharacterClass(params)]
    }

    @Transactional
    def save(CharacterClass characterClassInstance) {
        if (characterClassInstance == null) {
            notFound()
            return
        }

        if (characterClassInstance.hasErrors()) {
            render view:'create', model: [characterClassInstance: characterClassInstance]
            return
        }

        characterClassInstance.save flush:true

        flash.message = "${characterClassInstance.name} has been added"
        redirect characterClassInstance
    }

    def edit(CharacterClass characterClassInstance) {
        [characterClassInstance: characterClassInstance]
    }

    @Transactional
    def update(CharacterClass characterClassInstance) {
        if (characterClassInstance == null) {
            notFound()
            return
        }

        if (characterClassInstance.hasErrors()) {
            render view:'edit', model: [characterClassInstance: characterClassInstance]
            return
        }

        characterClassInstance.save flush:true

        flash.message = "${characterClassInstance.name} has been updated"
        redirect characterClassInstance
    }

    @Transactional
    def delete(CharacterClass characterClassInstance) {

        if (characterClassInstance == null) {
            notFound()
            return
        }

        characterClassInstance.delete flush:true

        flash.message = "${characterClassInstance.name} deleted"
        redirect action:"index", method:"GET"
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'characterClassInstance.label', default: 'CharacterClass'), params.id])
        redirect action: "index", method: "GET"
    }
}
