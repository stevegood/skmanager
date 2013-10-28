
<%@ page import="org.stevegood.game.PlayerCharacter" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>${playerCharacterInstance.name} - Level ${playerCharacterInstance.level} ${playerCharacterInstance.characterClass.name}</title>
	</head>
	<body>

    <skm:pageHeader class="col-lg-12">
        <h1>
            ${playerCharacterInstance.name}
            <span class="small text-muted">Level ${playerCharacterInstance.level} ${playerCharacterInstance.characterClass.name}</span>
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <g:form url="[resource:playerCharacterInstance, action:'delete']" method="DELETE" class="pull-right">
                    <g:link controller="playerCharacter" action="edit" resource="${playerCharacterInstance}" class="btn btn-info">
                        <span class="glyphicon glyphicon-pencil"></span>
                    </g:link>
                    <button type="submit" name="_action_delete" class="btn btn-danger" onclick="return confirm('Are you sure?');">
                        <span class="glyphicon glyphicon-trash"></span>
                    </button>
                </g:form>
            </sec:ifAllGranted>
        </h1>
    </skm:pageHeader>


    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Roles</h3>
                    </div>
                    <div class="panel-body">
                        <ul class="list-group">
                            <g:each in="${playerCharacterInstance.roles}" var="role">
                                <li class="list-group-item">
                                    ${role.name}
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Raids</h3>
                    </div>
                    <div class="panel-body">
                        <ul class="list-group">
                            <g:each in="${playerCharacterInstance.raids}" var="raid">
                                <li class="list-group-item">
                                    <g:link controller="raid" action="show" id="${raid.id}">${raid.name}</g:link>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Note</h3>
                    </div>
                    <div class="panel-body">
                        ${playerCharacterInstance.note?.encodeAsHTML()}
                    </div>
                </div>
            </div>

        </div>
    </div>


	</body>
</html>
