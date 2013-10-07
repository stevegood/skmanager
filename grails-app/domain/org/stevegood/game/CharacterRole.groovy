package org.stevegood.game

class CharacterRole {

    GameRole role
    PlayerCharacter character

    static constraints = {
        role unique: ['character']
    }

    static CharacterRole create(GameRole role, PlayerCharacter character) {
        CharacterRole.findOrCreateByRoleAndCharacter(role, character).save(flush: true)
    }
}
