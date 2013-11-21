package org.stevegood.sec

class User {

    static auditable = [ignore:['version','password']]

	transient springSecurityService

	String username
	String password
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
	}

	static mapping = {
        table 'skm_users'
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

    def addRole(String authority) {
        addRole(Role.findByAuthority(authority))
    }

    def addRole(Role role) {
        UserRole.findOrCreateByUserAndRole(this, role)?.save()
    }

    def removeRole(Role role) {
        UserRole.findByUserAndRole(this, role)?.delete(flush: true)
    }

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

    String toString() {
        username
    }

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}
