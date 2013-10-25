<div id="${raidMember.id}" class="row highlight-on-hover" data-raid-member-id="${raidMember.id}">
    <g:if test="${sortable}">
        <div class="col-lg-1" style="cursor: move;">
            <span class="glyphicon glyphicon-sort text-muted"></span>
        </div>
    </g:if>
    <div class="col-lg-${sortable ? '7' : '8'}">
        <g:link controller="playerCharacter" action="show" id="${raidMember.character.id}">
            ${raidMember.character.name}
        </g:link>
    </div>
    <div class="col-lg-1">
        <g:if test="${canManage && last}">
            <g:link class="btn btn-warning btn-xs move-to-bottom-btn"
                    controller="raidMember" action="moveToBottom"
                    params="${[raid_member_id: raidMember.id]}">
                <span class="glyphicon glyphicon-arrow-down"></span>
            </g:link>
        </g:if>
    </div>
    <div class="col-lg-1">
        <g:if test="${canManage}">
            <div class="dropdown">
                <a class="btn-xs text-muted" href="#" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-cog"></span>
                </a>
                <ul class="dropdown-menu">
                    <li role="presentation">
                        <g:if test="${raidMember.substitute}">
                            <g:link controller="raidMember" action="makeCore" params="${[raid_member_id: raidMember.id]}">
                                <span class="glyphicon glyphicon-arrow-up"></span>
                                Move to core list
                            </g:link>
                        </g:if>
                        <g:else>
                            <g:link controller="raidMember" action="makeSubstitute" params="${[raid_member_id: raidMember.id]}">
                                <span class="glyphicon glyphicon-arrow-down"></span>
                                Move to sub list
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
