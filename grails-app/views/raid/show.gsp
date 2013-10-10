
<%@ page import="org.stevegood.sk.Raid" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'raid.label', default: 'Raid')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <r:require module="bootstrap_js" />
	</head>
	<body>

    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <h2>
                        <g:link controller="user" action="show" id="${raidInstance?.owner?.id}">
                            ${raidInstance?.owner?.username.capitalize()}'s
                        </g:link>
                        ${raidInstance.name}
                    </h2>
                </div>
                <div class="col-lg-4 btns">
                    <sec:ifLoggedIn>
                        <g:if test="${sec.loggedInUserInfo(field: 'username') == raidInstance.owner.username || sec.ifAllGranted(roles: ['ROLE_ADMIN'])}">
                            <g:form url="[resource:raidInstance, action:'delete']" method="DELETE" class="pull-right">
                                <button id="add-character-btn" type="button" class="btn btn-primary">Add Character</button>
                                <g:link class="btn btn-info" action="edit" resource="${raidInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                                <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                            </g:form>
                        </g:if>
                    </sec:ifLoggedIn>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <g:each in="${characterClasses}" var="charClass">
                <div class="col-lg-${colWidth}">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">${charClass.name}</h3>
                        </div>
                        <div class="panel-body">
                            <ul>
                                %{-- TODO: list characters by class --}%
                                <g:each in="${raidInstance.members.collect{ it.character }.sort { it.name }}" var="pc">
                                    <g:if test="${pc.characterClass == charClass}">
                                        <li>
                                            <g:link controller="playerCharacter" action="show" id="${pc.id}">${pc.name}</g:link>
                                        </li>
                                    </g:if>
                                </g:each>
                            </ul>
                        </div>
                        <div class="panel-footer"></div>
                    </div>
                </div>
            </g:each>
        </div>
    </div>

    <div id="add-character-modal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Add Character to Raid</h4>
                </div>
                <div class="modal-body">
                    <form id="add-character-form" class="form form-horizontal" role="form">
                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="add-character-select">Character *:</label>
                            <div class="col-lg-9">
                                <select id="add-character-select" class="form-control" required="required"></select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="add-character-note">Note:</label>
                            <div class="col-lg-9">
                                <textarea class="form-control" id="add-character-note" rows="3"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="modal-add-character-btn" type="button" class="btn btn-primary" disabled="disabled">Add Character</button>
                </div>
            </div>
        </div>
    </div>

    <r:script>
    var skmanager = skmanager || {};
        skmanager.raid = {id: ${raidInstance.id}};
    </r:script>
    <g:javascript src="raid/show.js" />

	</body>
</html>
