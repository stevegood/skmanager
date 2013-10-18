package skmanager

import groovy.xml.MarkupBuilder

class SkmTagLib {
    static namespace = 'skm'

    def pageHeader = { attrs, body ->
        def writer = new StringWriter()
        def markup = new MarkupBuilder(writer)
        markup.div(class: 'page-header'){
            div(class: 'container') {
                div(class: 'row') {
                    div(body(), attrs)
                }
            }
        }

        out << writer.toString().decodeHTML()
    }
}
