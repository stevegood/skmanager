package org.stevegood.util

import grails.transaction.Transactional

@Transactional
class RiftService {

    def processGuildDump(File file) {
        // TODO: process XML file
        log.debug 'Starting to process Guild Dump'
        def xmlSlurper = new XmlSlurper().parse(file)
        def members = []
        xmlSlurper.Members.Member.each {
            members << [
                    name: it.Name.toString(),
                    level: it.Level.toString().toInteger(),
                    characterClass: it.Calling.toString(),
                    note: it.PersonalNotes.toString()
            ]
        }
        log.debug 'Dump has been processed!'
        return members
    }
}
