package org.stevegood.game

import org.stevegood.sk.RaidMember

class PlayerCharacter implements Serializable {

    static auditable = true
    static transients = ['roles', 'raids']

    Date dateCreated
    Date lastUpdated

    String name
    CharacterClass characterClass
    int level = 1
    String note

    static constraints = {
        name blank: false, unique: true
        characterClass nullable: false
        level min: 1
        note nullable: true, blank: true
    }

    static mapping = {
        note type: 'text'
        sort 'name'
    }

    String toString() {
        name
    }

    List<GameRole> getRoles() {
        if (this.id) {
            return CharacterRole.findAllByCharacter(this)?.collect { it?.role } ?: []
        } else {
            return []
        }
    }
    
    def addRole(GameRole role) {
        CharacterRole.create(role, this)
    }
    
    def removeRole(GameRole role) {
        CharacterRole.findByCharacterAndRole(this, role)?.delete()
    }

    def getRaids() {
        RaidMember.findAllByCharacter(this)?.collect { it.raid }?.unique() ?: []
    }

    def toMap() {
        [
                id: id,
                name: name,
                dateCreated: dateCreated,
                lastUpdated: lastUpdated,
                note: note,
                level: level,
                characterClass: [
                        id: characterClass.id,
                        name: characterClass.name
                ]
        ]
    }
}
