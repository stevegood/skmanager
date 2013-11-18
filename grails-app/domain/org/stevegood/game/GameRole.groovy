package org.stevegood.game

class GameRole {

    static auditable = true

    String name
    byte[] icon

    static constraints = {
        name blank: false, unique: true
        icon nullable: true
    }

    static mapping = {
        sort 'name'
    }

    String toString() {
        name
    }
}
