import org.stevegood.game.CharacterClass
import org.stevegood.game.GameRole
import org.stevegood.game.PlayerCharacter
import org.stevegood.sec.Role
import org.stevegood.sec.User
import org.stevegood.sec.UserRole

class BootStrap {

    def grailsApplication
    def playerCharacterService
    def riftService

    def init = { servletContext ->
        if (!User.count()) {
            User admin = new User(username: 'admin', password: 'password', enabled: true).save(flush: true, insert: true)
            Role roleAdmin = new Role(authority: 'ROLE_ADMIN').save(insert: true, flush: true)
            UserRole.create(admin, roleAdmin, true)
        }
        development {

            ['Tank', 'Healer', 'Support', 'DPS'].each {
                new GameRole(name: it).save(insert: true, flush: true)
            }

            // load up sample characters
            String filePath = new File(URLDecoder.decode(grailsApplication.classLoader.getResource('sample-guild.xml').getPath(), "utf-8")).getPath()
            File guildDump = new File(filePath)
            def characterData = riftService.processGuildDump(guildDump)
            playerCharacterService.processCharacterData(characterData)
        }
    }
    def destroy = {
    }
}
