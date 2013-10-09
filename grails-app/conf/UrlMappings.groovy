class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.${format})?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'dashboard', action: 'index')
        "/register"(controller: 'user', action: 'register')
        "/register/submit"(controller: 'user', action: 'saveRegistration')
        "500"(view:'/error')
	}
}
