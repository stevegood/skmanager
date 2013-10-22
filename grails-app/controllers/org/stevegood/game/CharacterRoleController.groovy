package org.stevegood.game


import grails.transaction.Transactional

@Transactional(readOnly = true)
class CharacterRoleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [characterRoleInstanceCount: CharacterRole.count(), characterRoleInstanceList: CharacterRole.list(params)]
    }

    def show(CharacterRole characterRoleInstance) {
        [characterRoleInstance: characterRoleInstance]
    }

    def create() {
        [characterRoleInstance: new CharacterRole(params)]
    }

    @Transactional
    def save(CharacterRole characterRoleInstance) {
        if (characterRoleInstance == null) {
            notFound()
            return
        }

        if (characterRoleInstance.hasErrors()) {
            render view:'create', model: [characterRoleInstance: characterRoleInstance]
            return
        }

        characterRoleInstance.save flush:true

        flash.message = "${characterRoleInstance.name} created!"
        redirect characterRoleInstance
    }

    def edit(CharacterRole characterRoleInstance) {
        [characterRoleInstance: characterRoleInstance]
    }

    @Transactional
    def update(CharacterRole characterRoleInstance) {
        if (characterRoleInstance == null) {
            notFound()
            return
        }

        if (characterRoleInstance.hasErrors()) {
            render view:'edit', model: [characterRoleInstance: characterRoleInstance]
            return
        }

        characterRoleInstance.save flush:true

        flash.message = "${characterRoleInstance.name} updated!"
        redirect characterRoleInstance
    }

    @Transactional
    def delete(CharacterRole characterRoleInstance) {

        if (characterRoleInstance == null) {
            notFound()
            return
        }

        characterRoleInstance.delete flush:true

        flash.message = "${characterRoleInstance.name} deleted!"
        redirect action:"index", method:"GET"
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'characterRoleInstance.label', default: 'CharacterRole'), params.id])
        redirect action: "index", method: "GET"
    }
}
