package org.stevegood.util

import grails.transaction.Transactional
import groovy.xml.MarkupBuilder
import org.stevegood.game.CharacterClass
import org.stevegood.game.GameRole
import org.stevegood.game.PlayerCharacter
import org.stevegood.sec.Role
import org.stevegood.sec.User
import org.stevegood.sec.UserRole
import org.stevegood.sk.Raid
import org.stevegood.sk.RaidManager
import org.stevegood.sk.RaidMember

@Transactional
class MigrationService {

    def playerCharacterService

    def loadFromExportData(File file) {
        def xml = new XmlSlurper().parse(file)
        def characterData = []

        // import roles
        xml.roles.role.each { _r ->
            Role.findOrCreateByAuthority(_r.@authority.toString()).save(flush: true, failOnError: true)
        }
        // import users
        xml.users.user.each { _u ->
            def user = User.findOrCreateByUsername(_u.@username.toString())
            if (!user.id) {
                user.password = 'temp_password!'
            }

            user.enabled = _u.@enabled as Boolean
            user.save(flush: true, failOnError: true)
            println user.id
            // add roles to users
            _u.roles.role.each { _r ->
                if (!user.authorities?.collect { it.authority }?.contains(_r.@authority.toString())) {
                    UserRole.create(user, Role.findByAuthority(_r.@authority.toString()))
                }
            }
        }
        // import GameRoles
        xml.gameRoles.gameRole.each { _gr ->
            GameRole.findOrCreateByName(_gr.@name.toString()).save(flush: true)
        }

        // import CharacterClasses
        xml.characterClasses.characterClass.each { _cc ->
            CharacterClass.findOrCreateByName(_cc.@name.toString()).save(flush: true)
        }

        // import PlayerCharacters
        xml.characters.character.each { _c ->
            characterData << [
                name: _c.@name.toString(),
                level: _c.@level.toString().toInteger(),
                characterClass: _c.characterClass.@name.toString(),
                note: _c.note.toString()
            ]
        }
        characterData = playerCharacterService.processCharacterData(characterData)

        // import Raids
        xml.raids.raid.each { _raid ->
            def raid = Raid.findOrCreateByNameAndOwner(_raid.@name.toString(), User.findByUsername(_raid.owner.@username.toString())).save(flush: true)

            // add RaidManagers
            _raid.managers.manager.each { _rman ->
                raid.addManager(User.findByUsername(_rman.user.@username.toString()))
            }

            // add RaidMembers
            _raid.members.member.each { _rmem ->
                def pc = PlayerCharacter.findByName(_rmem.character.@name.toString())
                println "${pc.name} -> Sub: ${_rmem.@substitute.toString().toLowerCase() == 'true'}"
                def raidMember = raid.addPlayerCharacter(pc, _rmem.@substitute.toString().toLowerCase() == 'true', _rmem.@onLeave.toString().toLowerCase() == 'true')
                if (!raidMember.id) {
                    raidMember.note = _rmem.note.toString()
                }
                raidMember.save(flush: true)
            }
        }

        return [characterData: characterData]
    }

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
