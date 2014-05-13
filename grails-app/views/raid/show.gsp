<%@ page import="org.stevegood.sk.Raid" %>
<g:set var="username" value="${sec.loggedInUserInfo(field: 'username')}" />
<g:set var="canManage" value="${username == raidInstance.owner.username || raidInstance.isManager(username.toString())}"/>
<sec:ifAllGranted roles="ROLE_ADMIN">
    <g:set var="canManage" value="${true}"/>
</sec:ifAllGranted>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'raid.label', default: 'Raid')}" />
		<title>${raidInstance.name}</title>
        <r:require module="typeahead" />
	</head>
	<body>

    <div id="pg-header" class="page-header">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <h2>${raidInstance.name}</h2>
                </div>
                <div class="col-lg-4 btns">
                    <sec:ifLoggedIn>
                        <g:if test="${canManage}">
                            <div class="pull-right">

                                <button id="add-character-btn" type="button" class="btn btn-primary">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <span class="glyphicon glyphicon-user"></span>
                                </button>

                                <div id="btn-group" class="btn-group">
                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        <span class="glyphicon glyphicon-cog dropdown-toggle" data-toggle="dropdown"></span> <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li>
                                            <g:link controller="raidMember" action="deactivateAllTempActive" id="${raidInstance.id}">
                                                <span class="glyphicon glyphicon-circle-arrow-down"></span> Reset all subs
                                            </g:link>
                                        </li>
                                        <li>
                                            <a href="#" id="raidStringMenuItem">
                                                <span class="glyphicon glyphicon-eye-open"></span> Show Raid String
                                            </a>
                                        </li>
                                        <g:if test="${sec.username() == raidInstance.owner.username}">
                                            <li>
                                                <g:link controller="raidManager" action="create" params="${['raid.id': raidInstance.id]}">
                                                    <span class="glyphicon glyphicon-tower"></span> Add Manager
                                                </g:link>
                                            </li>
                                            <li>
                                                <g:link action="edit" resource="${raidInstance}">
                                                    <span class="glyphicon glyphicon-pencil"></span> Edit Raid
                                                </g:link>
                                            </li>
                                            <li class="divider"></li>
                                            <li>
                                                <g:link controller="raid" action="delete" id="${raidInstance.id}" onclick="return confirm('Are you sure?');">
                                                    <span class="glyphicon glyphicon-trash"></span> Delete Raid
                                                </g:link>
                                            </li>
                                        </g:if>
                                    </ul>
                                </div>
                            </div>
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

    <div id="raidStringModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Raid String</h4>
                </div>
                <div class="modal-body">
                    <p>Copy the text below and paste it into the SKManager addon.</p>
                    <g:textArea name="raidString" cols="100" rows="10" class="form-control" value="${raidInstance.toRaidString()}" />
                </div>
                <div class="modal-footer">
                    <button id="raidStringImportBtn" class="btn btn-default">Import Raid String</button>
                </div>
            </div>
        </div>
    </div>

    <div id="raidStringImportModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Import Raid String</h4>
                </div>
                <div class="modal-body">
                    <p>Paste a raid string below to import it into SKManager.</p>
                    <g:form name="importRaidStringForm" controller="raid" action="importRaidString">
                        <g:hiddenField name="id" value="${raidInstance.id}" />
                        <g:textArea name="importString" cols="100" rows="10" class="form-control" />
                    </g:form>
                </div>
                <div class="modal-footer">
                    <button id="importRaidStringSubmitBtn" class="btn btn-primary">Import Raid String</button>
                </div>
            </div>
        </div>
    </div>

    <r:script disposition="head">
    var skmanager = skmanager || {};
        skmanager.raid = {id: ${raidInstance.id}};
        skmanager.raidString = "${raidInstance.toRaidString()}";
        skmanager.addCharacterUrl = "${createLink(controller: 'raid', action: 'addCharacter')}";
        skmanager.availableForRaidUrl = "${createLink(controller: 'playerCharacter', action: 'availableForRaid')}";
        skmanager.repositionMembersUrl = "${createLink(controller: 'raidMember', action: 'repositionMembers')}";
    </r:script>
    <script type="text/javascript" src="${resource(dir: 'js/raid', file: 'show.js')}"></script>

	</body>
</html>
