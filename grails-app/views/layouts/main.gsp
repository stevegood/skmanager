<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
        <r:require modules="bootstrap_js,application" />
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body>

        %{-- navigation --}%
        <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <g:link class="navbar-brand" controller="dashboard" action="index">SKManager</g:link>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <sec:ifLoggedIn>
                        <li>
                            <g:link controller="dashboard" action="index">Dashboard</g:link>
                        </li>
                        <li class="dropdown">
                            <a id="raidsDD" class="dropdown-toggle" href="#" data-toggle="dropdown" role="button">
                                Raids
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu" aria-labeledby="raidsDD" role="menu">
                                <li role="presentation">
                                    <g:link controller="raid" action="mine">My Raids</g:link>
                                </li>
                                <li role="presentation">
                                    <g:link controller="raid" action="index">Browse Raids</g:link>
                                </li>
                                <li class="divider" role="presentation"></li>
                                <li role="presentation">
                                    <g:link controller="raid" action="create">Create Raid</g:link>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a id="charactersDD" class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                                Characters
                                <b class="caret"></b>
                            </a>
                            <ul class="dropdown-menu" aria-labeledby="charactersDD" role="menu">
                                <li role="presentation">
                                    <g:link controller="playerCharacter" action="index">Browse Characters</g:link>
                                </li>
                                <li class="divider" role="presentation"></li>
                                <li role="presentation">
                                    <g:link controller="playerCharacter" action="create">Create Character</g:link>
                                </li>
                            </ul>
                        </li>
                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <li>
                                <g:link controller="admin" action="index">Admin</g:link>
                            </li>
                        </sec:ifAllGranted>
                    </sec:ifLoggedIn>
                </ul>

                <ul class="nav navbar-nav pull-right">
                    <li>
                        <sec:ifLoggedIn>
                            <g:link controller="logout" action="index">Logout</g:link>
                        </sec:ifLoggedIn>
                        <sec:ifNotLoggedIn>
                            <g:link controller="login" action="auth">Log In</g:link>
                        </sec:ifNotLoggedIn>
                    </li>
                </ul>
            </div>
        </div>
        </div>

        %{-- body --}%
		<g:layoutBody/>
        %{-- footer --}%
		<r:layoutResources />
	</body>
</html>
