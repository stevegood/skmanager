
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
        <r:require module="typeahead" />
	</head>
	<body>

    <div class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <h2>
                        %{--<g:link controller="user" action="show" id="${raidInstance?.owner?.id}">--}%
                            ${raidInstance?.owner?.username.capitalize()}'s
                        %{--</g:link>--}%
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

    <div id="lists" class="container">
        <div class="row">
            <g:each in="${raidMembersByClass}" var="classMap">
                <div class="col-lg-${colWidth}">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">${classMap.characterClass.name}</h3>
                        </div>
                        <div class="panel-body">
                            <div class="container">
                                %{-- list characters by class --}%
                                %{-- TODO: make these lists sortable with jqueryui. example: http://jqueryui.com/sortable/#placeholder --}%
                                <div id="${classMap.characterClass.name}-members" class="${canManage ? 'sortable' : ''}">
                                    <g:each in="${classMap.members}" var="raidMember" status="i">
                                        <g:render template="raidMember" model="${[sortable: true, canManage: canManage, raidMember: raidMember, last: i < classMap.members.size()-1]}" />
                                    </g:each>
                                </div>

                                <g:if test="${classMap.subs.size()}">
                                    <hr>
                                    <div id="${classMap.characterClass.name}-subs">
                                        <g:each in="${classMap.subs}" var="raidMember" status="i">
                                            <g:render template="raidMember" model="${[sortable: false, canManage: canManage, raidMember: raidMember, last: i < classMap.subs.size()-1]}" />
                                        </g:each>
                                    </div>
                                </g:if>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <g:set var="membersPlural" value="${classMap.members.size() == 0 || classMap.members.size() > 1}" />
                            <g:set var="subsPlural" value="${classMap.subs.size() == 0 || classMap.subs.size() > 1}" />
                            ${classMap.members.size()} member${membersPlural ? 's' : ''}, ${classMap.subs.size()} sub${subsPlural ? 's' : ''}
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
                            <label class="col-lg-3 control-label" for="search">Search</label>
                            <div class="col-lg-9">
                                <input id="search" class="form-control" type="text"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-3 control-label" for="add-character-select">Character *:</label>
                            <div class="col-lg-9">
                                <select id="add-character-select" class="form-control" required="required"></select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-lg-offset-3 col-lg-9">
                                <div class="checkbox">
                                    <label>
                                        <g:checkBox name="substitute" /> Substitute
                                    </label>
                                </div>
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

    <r:script disposition="head">
    var skmanager = skmanager || {};
        skmanager.raid = {id: ${raidInstance.id}};
    </r:script>
    <script type="text/javascript" src="${resource(dir: 'js/raid', file: 'show.js')}"></script>

	</body>
</html>
