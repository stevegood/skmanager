package org.stevegood.game



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GameRoleController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [gameRoleInstanceCount: GameRole.count(), gameRoleInstanceList: GameRole.list(params)]
    }

    def show(GameRole gameRoleInstance) {
        [gameRoleInstance: gameRoleInstance]
    }

    def create() {
        [gameRoleInstance: new GameRole(params)]
    }

    @Transactional
    def save(GameRole gameRoleInstance) {
        if (gameRoleInstance == null) {
            notFound()
            return
        }

        if (gameRoleInstance.hasErrors()) {
            render view:'create', model: [gameRoleInstance: gameRoleInstance]
            return
        }

        def iconFile = request.getFile('icon')
        if (iconFile && !iconFile.empty) {
            gameRoleInstance.icon = iconFile.bytes
        }

        gameRoleInstance.save flush:true

        flash.message = message(code: 'default.created.message', args: [message(code: 'gameRoleInstance.label', default: 'GameRole'), gameRoleInstance.id])
        redirect gameRoleInstance
    }

    def edit(GameRole gameRoleInstance) {
        [gameRoleInstance: gameRoleInstance]
    }

    @Transactional
    def update(GameRole gameRoleInstance) {
        if (gameRoleInstance == null) {
            notFound()
            return
        }

        if (gameRoleInstance.hasErrors()) {
            render view:'edit', model: [gameRoleInstance: gameRoleInstance]
            return
        }

        def iconFile = request.getFile('icon')
        if (iconFile && !iconFile.empty) {
            gameRoleInstance.icon = iconFile.bytes
        }

        gameRoleInstance.save flush:true

        flash.message = message(code: 'default.updated.message', args: [message(code: 'GameRole.label', default: 'GameRole'), gameRoleInstance.id])
        redirect gameRoleInstance
    }

    @Transactional
    def delete(GameRole gameRoleInstance) {

        if (gameRoleInstance == null) {
            notFound()
            return
        }

        gameRoleInstance.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'GameRole.label', default: 'GameRole'), gameRoleInstance.id])
        redirect action:"index", method:"GET"
    }

    def icon(GameRole gameRoleInstance){
        byte[] iconBytes = gameRoleInstance.icon
        response.outputStream << iconBytes
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'gameRoleInstance.label', default: 'GameRole'), params.id])
        redirect action: "index", method: "GET"
    }
}
