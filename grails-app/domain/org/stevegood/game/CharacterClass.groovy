package org.stevegood.game

class CharacterClass implements Serializable {

    static auditable = true

    String name

    static constraints = {
        name blank: false, unique: true
    }

    static mapping ={
        sort 'name'
    }

    String toString() {
        name
    }
}
