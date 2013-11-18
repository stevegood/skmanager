package skmanager

import groovy.xml.MarkupBuilder

class SkmTagLib {
    static namespace = 'skm'

    def pageHeader = { attrs, body ->
        def writer = new StringWriter()
        def markup = new MarkupBuilder(writer)
        if (!attrs.class) {
            attrs.class = 'col-lg-12'
        }
        markup.div(class: 'page-header'){
            div(class: 'container') {
                div(class: 'row') {
                    div(body(), attrs)
                }
            }
        }

        out << writer.toString().decodeHTML()
    }

    def userLink = { attrs, body ->
        def url = createLink(controller: 'user', action: 'show', params: [username: attrs.user.username])
        def a = "<a href=\"$url\""
        attrs.each { k, v ->
            if (k != 'user') {
                a += " $k=\"$v\""
            }
        }
        a += ">${body ?: attrs.user.username}</a>"
        out << a
    }

    def formatBoolean = { attrs ->
        def trueClass = attrs.true ?: 'glyphicon-ok'
        def falseClass = attrs.false ?: 'glyphicon-remove'
        out << "<span class=\"glyphicon ${attrs.boolean ? trueClass : falseClass}\"></span>"
    }
}
