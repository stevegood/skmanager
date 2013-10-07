import org.stevegood.sec.User

class BootStrap {

    def init = { servletContext ->
        development {
            User admin = new User(username: 'admin', password: 'password', enabled: true).save(flush: true, insert: true)
        }
    }
    def destroy = {
    }
}
