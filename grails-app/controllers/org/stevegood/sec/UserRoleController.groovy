package org.stevegood.sec

import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserRoleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userRoleInstanceCount: UserRole.count(), userRoleInstanceList: UserRole.list(params)]
    }

    def show() {
        def userRoleInstance = UserRole.get(params.userid as long, params.roleid as long)
        [userRoleInstance: userRoleInstance]
    }

    def create() {
        [userRoleInstance: new UserRole(params)]
    }

    @Transactional
    def save(UserRole userRoleInstance) {
        if (userRoleInstance == null) {
            notFound()
            return
        }

        if (userRoleInstance.hasErrors()) {
            render view:'create', model: [userRoleInstance: userRoleInstance]
            return
        }

        userRoleInstance.save flush:true

        flash.message = message(code: 'default.created.message', args: [message(code: 'userRoleInstance.label', default: 'UserRole'), userRoleInstance.id])
        redirect action: 'index'
    }

    @Transactional
    def delete() {

        def userRoleInstance = UserRole.get(params.userid as long, params.roleid as long)

        if (userRoleInstance == null) {
            notFound()
            return
        }

        userRoleInstance.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'UserRole.label', default: 'UserRole'), userRoleInstance.id])
        redirect action:"index", method:"GET"
    }

    protected void notFound() {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'userRoleInstance.label', default: 'UserRole'), params.id])
        redirect action: "index", method: "GET"
    }
}
