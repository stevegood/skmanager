modules = {
    application {
        resource url: 'css/bootstrap-cosmo.min.css'
        resource url: 'css/main.css'
        resource url: 'js/application.js'
    }

    jqueryui {
        dependsOn 'jquery'
        resource url: 'css/custom-theme/jquery-ui-1.10.3.custom.css'
        resource url: 'css/custom-theme/jquery.ui.1.10.3.ie.css', wrapper: { s ->
            "<!--[if lt IE 9]>$s<![endif]-->"
        }
        resource url: 'js/jquery-ui-1.10.3.custom.min.js', disposition: 'head'
    }

    bootstrap_js {
        dependsOn 'jquery'
        resource url: 'js/bootstrap.min.js'
    }

    typeahead {
        dependsOn 'bootstrap_js'
        resource url: 'css/typeahead.js-bootstrap.css'
        resource url: 'js/typeahead.min.js'
    }

    user_registration {
        dependsOn 'jquery'
        resource url: 'js/user/registration.js'
    }
}
