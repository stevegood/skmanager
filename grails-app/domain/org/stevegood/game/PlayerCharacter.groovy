package org.stevegood.game

class PlayerCharacter {

    static transients = ['roles']

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
        CharacterRole.findAllByCharacter(this)?.collect { it.role } ?: []
    }
    
    def addRole(GameRole role) {
        CharacterRole.create(role, this)
    }
    
    def removeRole(GameRole role) {
        CharacterRole.findAllByCharacterAndRole(this, role)?.delete(flush: true)
    }
}
