package org.stevegood.sec

class Role {

    static auditable = true

	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}

    String toString() {
        authority
    }
}
