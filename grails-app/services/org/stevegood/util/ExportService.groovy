package org.stevegood.util

import grails.transaction.Transactional
import groovy.xml.MarkupBuilder
import org.stevegood.game.CharacterClass
import org.stevegood.game.GameRole
import org.stevegood.game.PlayerCharacter
import org.stevegood.sec.Role
import org.stevegood.sec.User
import org.stevegood.sk.Raid
import org.stevegood.sk.RaidManager
import org.stevegood.sk.RaidMember

@Transactional
class ExportService {

    def systemDump(Writer writer) {
        def xml = new MarkupBuilder(writer)
        xml.skmanager() {
            roles {
                Role.list().each { Role roleInstance ->
                    role(id: roleInstance.id ,authority: roleInstance.authority)
                }
            }

            users {
                User.list().each { User userInstance ->
                    user(id: userInstance.id, username: userInstance.username, enabled: userInstance.enabled) {
                        roles {
                            userInstance.authorities?.each { Role roleInstance ->
                                role(id: roleInstance.id ,authority: roleInstance.authority)
                            }
                        }
                    }
                }
            }

            gameRoles {
                GameRole.list().each { GameRole gRole ->
                    gameRole(id: gRole.id, name: gRole.name)
                }
            }

            characterClasses {
                CharacterClass.list().each { CharacterClass cClass ->
                    characterClass(id: cClass.id, name: cClass.name)
                }
            }

            characters {
                PlayerCharacter.list().each { PlayerCharacter pc ->
                    character(id: pc.id, name: pc.name, level: pc.level) {
                        note(pc?.note?.trim() ?: '')
                        characterClass(id: pc?.characterClass.id, name: pc?.characterClass.name)
                        gameRoles {
                            pc?.roles?.each { gameRoleInstance ->
                                gameRole(id: gameRoleInstance.id, name: gameRoleInstance.name)
                            }
                        }
                    }
                }
            }

            raids {
                Raid.list().each { Raid raidInstance ->
                    raid(id: raidInstance.id, name: raidInstance.name, hidden: raidInstance.hidden) {
                        owner(id: raidInstance.owner.id, username: raidInstance.owner.username)
                        managers {
                            raidInstance.managers?.each { RaidManager rManager ->
                                manager(id: rManager.id) {
                                    user(id: rManager.manager.id, username: rManager.manager.username)
                                }
                            }
                        }

                        members {
                            raidInstance.members?.each { RaidMember rMember ->
                                member(id: rMember.id, listPosition: rMember.listPosition, substitute: rMember.substitute, tempActive: rMember.tempActive, onLeave: rMember.onLeave) {
                                    note(rMember.note?.trim() ?: '')
                                    character(id: rMember.character.id, name: rMember.character.name, level: rMember.character.level) {
                                        characterClass(id: rMember.character.characterClass.id, name: rMember.character.characterClass.name)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        return xml
    }
}
