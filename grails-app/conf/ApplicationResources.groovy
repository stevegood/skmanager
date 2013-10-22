modules = {
    application {
        resource url: 'css/bootstrap-cosmo.min.css'
        resource url: 'css/main.css'
        resource url: 'js/application.js'
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
