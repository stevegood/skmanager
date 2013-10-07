package org.stevegood.game

class GameRole {

    String name

    static constraints = {
        name blank: false, unique: true
    }

    static mapping = {
        sort 'name'
    }

    String toString() {
        name
    }
}
