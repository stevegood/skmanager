<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<table class="table table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="name" title="${message(code: 'raid.name.label', default: 'Name')}" />

        <th><g:message code="raid.owner.label" default="Owner" /></th>

        <g:sortableColumn property="dateCreated" title="${message(code: 'raid.dateCreated.label', default: 'Date Created')}" />

        <g:sortableColumn property="lastUpdated" title="${message(code: 'raid.lastUpdated.label', default: 'Last Updated')}" />

    </tr>
    </thead>
    <tbody>
    <g:each in="${raidInstanceList}" status="i" var="raidInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

            <td><g:link action="show" id="${raidInstance.id}">${fieldValue(bean: raidInstance, field: "name")}</g:link></td>

            <td>${fieldValue(bean: raidInstance, field: "owner")}</td>

            <td><g:formatDate date="${raidInstance.dateCreated}" /></td>

            <td><g:formatDate date="${raidInstance.lastUpdated}" /></td>

        </tr>
    </g:each>
    </tbody>
</table>
