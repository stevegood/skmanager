import org.stevegood.game.CharacterClass
import org.stevegood.game.GameRole
import org.stevegood.sec.Role
import org.stevegood.sec.User
import org.stevegood.sec.UserRole

class BootStrap {

    def init = { servletContext ->
        if (!User.count()) {
            User admin = new User(username: 'admin', password: 'password', enabled: true).save(flush: true, insert: true)
            Role roleAdmin = new Role(authority: 'ROLE_ADMIN').save(insert: true, flush: true)
            UserRole.create(admin, roleAdmin, true)
        }
        development {
            ['Rogue', 'Mage', 'Warrior', 'Cleric'].each {
                new CharacterClass(name: it).save(insert: true, flush: true)
            }

            ['Tank', 'Healer', 'Support', 'DPS'].each {
                new GameRole(name: it).save(insert: true, flush: true)
            }
        }
    }
    def destroy = {
    }
}
