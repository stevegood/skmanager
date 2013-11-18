package org.stevegood.sec



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceCount: User.count()]
    }

    def show() {
        User userInstance = User.findByUsername(params.username as String)
        [userInstance: userInstance]
    }

    def create() {
        [userInstance: new User(params)]
    }

    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            render view:'create', model: [userInstance: userInstance]
            return
        }

        userInstance.save flush:true

        flash.message = message(code: 'default.created.message', args: [message(code: 'userInstance.label', default: 'User'), userInstance.id])
        redirect userInstance
    }

    def register() {
        [userInstance: new User(params)]
    }

    @Transactional
    def saveRegistration() {
        def userInstance = User.findOrCreateByUsername(params.username)
        userInstance.properties = params

        if (userInstance.id) {
            flash.message = message(code: 'user.exists', default: 'A user with that username already exists!')
            flash.type = 'danger'
            render view: 'register', model: [userInstance: userInstance]
            return
        }

        if (params.password != params.password2) {
            flash.message = message(code: 'passwords.dont.match', default: 'Passwords don\'t match.')
            flash.type = 'danger'
            render view: 'register', model: [userInstance: userInstance]
            return
        }

        if (userInstance.hasErrors()) {
            render view:'register', model: [userInstance: userInstance]
            return
        }

        userInstance.save flush:true

        flash.message = "$userInstance.username has been registered!"
        redirect controller: 'login', action: 'auth', params: [username: userInstance.username]
    }

    def edit(User userInstance) {
        [userInstance: userInstance]
    }

    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            render view:'edit', model: [userInstance: userInstance]
            return
        }

        userInstance.save flush:true

        flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
        redirect userInstance
    }

    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        userInstance.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
        redirect action:"index", method:"GET"
    }

    @Transactional
    def enableDisable(User userInstance) {
        toggleProperty(userInstance, 'enabled')
    }

    @Transactional
    def lockUnlock(User userInstance) {
        toggleProperty(userInstance, 'accountLocked')
    }

    @Transactional
    def expireActivateAccount(User userInstance) {
        toggleProperty(userInstance, 'accountExpired')
    }

    @Transactional
    def expireActivatePassword(User userInstance) {
        toggleProperty(userInstance, 'passwordExpired')
    }

    protected void toggleProperty(User userInstance, String property) {
        userInstance[property] = !userInstance[property]
        userInstance.save()
        redirect action: 'show', params: [username: userInstance.username]
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'userInstance.label', default: 'User'), params.id])
        flash.type = 'danger'
        redirect action: "index", method: "GET"
    }
}
