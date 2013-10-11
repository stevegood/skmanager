
<%@ page import="org.stevegood.sk.Raid" %>
<g:set var="canManage" value="${sec.loggedInUserInfo(field: 'username') == raidInstance.owner.username}"/>
<sec:ifAllGranted roles="ROLE_ADMIN">
    <g:set var="canManage" value="${true}"/>
</sec:ifAllGranted>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'raid.label', default: 'Raid')}" />
		<title>${raidInstance?.owner?.username.capitalize()}'s ${raidInstance.name}</title>
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
                        <g:if test="${canManage}">
                            <g:form url="[resource:raidInstance, action:'delete']" method="DELETE" class="pull-right">
                                <button id="add-character-btn" type="button" class="btn btn-primary">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <span class="glyphicon glyphicon-user"></span>
                                </button>
                                <g:link class="btn btn-info" action="edit" resource="${raidInstance}">
                                    <span class="glyphicon glyphicon-pencil"></span>
                                </g:link>
                                <button type="submit" name="_action_delete" class="btn btn-danger" onclick="return confirm('Are you sure?');">
                                    <span class="glyphicon glyphicon-trash"></span>
                                </button>
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
                            <div class="container">
                                %{-- TODO: list characters by class --}%
                                <g:set var="classList" value="${raidInstance.members.findAll { it.character.characterClass == charClass }.sort{ it.listPosition }}" />
                                <g:each in="${classList}" var="raidMember" status="i">
                                    <div class="row highlight-on-hover">
                                        <div class="col-lg-8">
                                            <g:link controller="playerCharacter" action="show" id="${raidMember.character.id}">${raidMember.character.name}</g:link>
                                        </div>
                                        <div class="col-lg-1">
                                            <g:if test="${canManage && i < classList.size()-1}">
                                                <g:link class="btn btn-warning btn-xs move-to-bottom-btn"
                                                        controller="raidMember" action="moveToBottom"
                                                        params="${[raid_member_id: raidMember.id]}">
                                                    <span class="glyphicon glyphicon-arrow-down"></span>
                                                </g:link>
                                            </g:if>
                                        </div>
                                        <div class="col-lg-1">
                                            <g:if test="${canManage}">
                                                <g:link class="btn btn-danger btn-xs" controller="raidMember" action="removeFromRaid"
                                                        params="${[raid_member_id: raidMember.id]}">
                                                    <span class="glyphicon glyphicon-trash"></span>
                                                </g:link>
                                            </g:if>
                                        </div>
                                    </div>
                                </g:each>
                            </div>
                        </div>
                        <div class="panel-footer text-muted">
                            ${classList.size()} ${charClass.name}<g:if test="${classList.size() > 1 || classList.size() == 0}">s</g:if>
                        </div>
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
