<div id="${raidMember.id}" class="row highlight-on-hover" data-raid-member-id="${raidMember.id}">

        <div class="col-lg-1">
            <g:if test="${sortable}">
                <span class="glyphicon glyphicon-sort text-muted sort-icon"></span>
            </g:if>
            <g:else>
                <span class="label label-primary">S</span>
            </g:else>
        </div>

    <div class="col-lg-8">
        <g:link controller="playerCharacter" action="show" id="${raidMember.character.id}"
                class="${raidMember.substitute && raidMember.tempActive ? 'label label-primary' : ''}">
                ${raidMember.character.name}
        </g:link>
        <g:each in="${raidMember.character.roles}" var="role">
            <span class="role-icon-extra-tiny">
                <g:if test="${role.icon}">

                        <img src="${createLink(controller: 'gameRole', action: 'icon', id: role.id)}"
                             alt="${role.name}"/>

                </g:if>
            </span>
        </g:each>
    </div>
    <div class="col-lg-1">
        <g:if test="${canManage}">
            <div class="dropdown">
                <a class="btn-xs text-muted" href="#" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-cog"></span>
                </a>
                <ul class="dropdown-menu">
                    <g:if test="${last && (!raidMember.substitute || (raidMember.substitute && raidMember.tempActive))}">
                        <li role="resentation">
                            <g:link class="alert-warning"
                                    controller="raidMember" action="moveToBottom"
                                    params="${[raid_member_id: raidMember.id]}">
                                <span class="glyphicon glyphicon-arrow-down"></span>
                                Move to bottom
                            </g:link>
                        </li>
                    </g:if>

                    <g:if test="${raidMember.substitute && !raidMember.tempActive}">
                        <li role="presentation">
                            <g:link controller="raidMember" action="makeSubTempActive" params="${[raid_member_id: raidMember.id]}">
                                <span class="glyphicon glyphicon-arrow-up"></span>
                                Make sub active
                            </g:link>
                        </li>
                    </g:if>

                    <g:if test="${raidMember.substitute && raidMember.tempActive}">
                        <li role="presentation">
                            <g:link controller="raidMember" action="removeTempActiveSub" params="${[raid_member_id: raidMember.id]}">
                                <span class="glyphicon glyphicon-arrow-down"></span>
                                Make sub inactive
                            </g:link>
                        </li>
                    </g:if>

                    <li role="presentation">
                        <g:if test="${raidMember.substitute}">
                            <g:link controller="raidMember" action="makeCore" params="${[raid_member_id: raidMember.id]}">
                                <span class="glyphicon glyphicon-plus"></span>
                                Add to core list
                            </g:link>
                        </g:if>
                        <g:else>
                            <g:link controller="raidMember" action="makeSubstitute" params="${[raid_member_id: raidMember.id]}">
                                <span class="glyphicon glyphicon-minus"></span>
                                Remove from core list
                            </g:link>
                        </g:else>
                    </li>

                    <li class="divider" role="presentation"></li>
                    <li role="presentation">
                        <g:link controller="raidMember" action="removeFromRaid" params="${[raid_member_id: raidMember.id]}">
                            <span class="glyphicon glyphicon-trash"></span>
                            Remove from raid
                        </g:link>
                    </li>
                </ul>
            </div>
        </g:if>
    </div>
</div>
