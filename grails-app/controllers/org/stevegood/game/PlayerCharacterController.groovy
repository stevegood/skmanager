package org.stevegood.game

import grails.converters.JSON
import org.stevegood.sk.Raid
import org.stevegood.sk.RaidMember

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PlayerCharacterController {

    def migrationService
    def playerCharacterService
    def riftService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [playerCharacterInstanceList: PlayerCharacter.list(params), playerCharacterInstanceCount: PlayerCharacter.count()]
    }

    def show(PlayerCharacter playerCharacterInstance) {
        [playerCharacterInstance: playerCharacterInstance]
    }

    def create() {
        [playerCharacterInstance: new PlayerCharacter(params), roleInstanceList: GameRole.list()]
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
        params?.roles?.each {
            playerCharacterInstance.addRole(GameRole.get(it as long))
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'playerCharacterInstance.label', default: 'PlayerCharacter'), playerCharacterInstance.id])
        redirect playerCharacterInstance
    }

    def edit(PlayerCharacter playerCharacterInstance) {
        [playerCharacterInstance: playerCharacterInstance, roleInstanceList: GameRole.list()]
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

        if (params.roles instanceof String) {
            params.roles = [params.roles]
        }

        playerCharacterInstance.save flush:true
        playerCharacterInstance.roles?.each {
            playerCharacterInstance.removeRole(it)
        }

        params?.roles?.each {
            playerCharacterInstance.addRole(GameRole.get(it as long))
        }

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
            order 'name', 'asc'
        }
        def result = [playerCharacters: pcs*.toMap()]
        render result as JSON
    }

    def importCharacterData() {}

    @Transactional
    def saveImportCharacterdata() {
        // import the data from uploaded file
        def file = request.getFile('characterDataFile')
        if (file.empty) {
            flash.message = 'File cannot be empty'
            render view: 'importCharacterData'
            return
        }

        def ts = new Date().time.toString()
        File tmpFile = File.createTempFile(ts, file.originalFilename as String)
        file.transferTo(tmpFile)

        def characterData
        switch(params.game.toLowerCase()) {
            case 'rift':
                characterData = riftService.processGuildDump(tmpFile)
                break
            case 'skmanager':
                def dataLoadResult = migrationService.loadFromExportData(tmpFile)
                flash.message = "${dataLoadResult.characterData.charactersAdded} character(s) added, ${dataLoadResult.characterData.charactersUpdated} character(s) updated and ${dataLoadResult.characterData.charactersIgnored} character(s) ignored"
                redirect controller: 'admin', action: 'index'
                return
                break
        }

        if (!characterData) {
            flash.message = 'Either no data exists in the file supplied or it is from an unsupported game.  Please check your file and try again.'
            render view: 'importCharacterData'
            return
        }

        def processedData = playerCharacterService.processCharacterData(characterData)

        flash.message = "${processedData.charactersAdded} character(s) added, ${processedData.charactersUpdated} character(s) updated and ${processedData.charactersIgnored} character(s) ignored"
        redirect controller: 'admin', action: 'index'
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'playerCharacterInstance.label', default: 'PlayerCharacter'), params.id])
        redirect action: "index", method: "GET"
    }
}
