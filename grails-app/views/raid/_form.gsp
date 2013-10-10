<%@ page import="org.stevegood.sk.Raid" %>



%{--<sec:ifAllGranted roles="ROLE_ADMIN">--}%
    %{--<div class="fieldcontain ${hasErrors(bean: raidInstance, field: 'owner', 'error')} required">--}%
        %{--<label for="owner">--}%
            %{--<g:message code="raid.owner.label" default="Owner" />--}%
            %{--<span class="required-indicator">*</span>--}%
        %{--</label>--}%
        %{--<g:select id="owner" name="owner.id" from="${org.stevegood.sec.User.list()}" optionKey="id" required="" value="${raidInstance?.owner?.id}" class="many-to-one"/>--}%
    %{--</div>--}%
%{--</sec:ifAllGranted>--}%

<g:hiddenField name="owner.id" value="${sec.loggedInUserInfo(field: 'id')}" />

<div class="form-group ${hasErrors(bean: raidInstance, field: 'name', 'error')}">
    <label for="name" class="col-lg-2 control-label">
        <g:message code="raid.name.label" default="Name" />
    </label>
    <div class="col-lg-10">
        <g:textField name="name" value="${raidInstance?.name}" class="form-control" required="required"/>
    </div>
</div>

%{--<div class="form-group ${hasErrors(bean: raidInstance, field: 'hidden', 'error')} ">--}%
    %{--<div class="col-lg-offset-3 lg-col-9">--}%
        %{--<div class="checkbox">--}%
            %{--<label for="hidden">--}%
                %{--<g:checkBox name="hidden" value="${raidInstance?.hidden}" />--}%
                %{--<g:message code="raid.hidden.label" default="Hidden" />--}%
            %{--</label>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</div>--}%

