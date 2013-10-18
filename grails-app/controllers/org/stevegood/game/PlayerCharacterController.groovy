package org.stevegood.game

import grails.converters.JSON
import org.stevegood.sk.Raid
import org.stevegood.sk.RaidMember

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PlayerCharacterController {

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [playerCharacterInstanceList: PlayerCharacter.list(params), playerCharacterInstanceCount: PlayerCharacter.count()]
    }

    def show(PlayerCharacter playerCharacterInstance) {
        [playerCharacterInstance: playerCharacterInstance]
    }

    def create() {
        [playerCharacterInstance: new PlayerCharacter(params)]
    }

    @Transactional
    def save(PlayerCharacter playerCharacterInstance) {
        if (playerCharacterInstance == null) {
            notFound()
            return
        }

        if (playerCharacterInstance.hasErrors()) {
            render view:'create', model: [playerCharacterInstance: playerCharacterInstance]
            return
        }

        playerCharacterInstance.save flush:true

        flash.message = message(code: 'default.created.message', args: [message(code: 'playerCharacterInstance.label', default: 'PlayerCharacter'), playerCharacterInstance.id])
        redirect playerCharacterInstance
    }

    def edit(PlayerCharacter playerCharacterInstance) {
        [playerCharacterInstance: playerCharacterInstance]
    }

    @Transactional
    def update(PlayerCharacter playerCharacterInstance) {
        if (playerCharacterInstance == null) {
            notFound()
            return
        }

        if (playerCharacterInstance.hasErrors()) {
            render view:'edit', model: [playerCharacterInstance: playerCharacterInstance]
            return
        }

        playerCharacterInstance.save flush:true

        flash.message = message(code: 'default.updated.message', args: [message(code: 'PlayerCharacter.label', default: 'PlayerCharacter'), playerCharacterInstance.id])
        redirect playerCharacterInstance
    }

    @Transactional
    def delete(PlayerCharacter playerCharacterInstance) {

        if (playerCharacterInstance == null) {
            notFound()
            return
        }

        playerCharacterInstance.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'PlayerCharacter.label', default: 'PlayerCharacter'), playerCharacterInstance.id])
        redirect action:"index", method:"GET"
    }

    def availableForRaid() {
        Raid raid = Raid.get(params.raid_id)
        def pcs = PlayerCharacter.withCriteria {
            raid.members.each { RaidMember raidMember ->
                ne 'id', raidMember.character.id
            }
        }
        def result = [playerCharacters: pcs]
        render result as JSON
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'playerCharacterInstance.label', default: 'PlayerCharacter'), params.id])
        redirect action: "index", method: "GET"
    }
}
