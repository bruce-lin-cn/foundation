<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="\${cgDomainProperties.cgChinese}" />
        <title><g:message code="\${entityName}明细" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="\${createLink(uri: '/')}">首页</a></span>
            <span class="menuButton"><g:link class="list" action="list">\${entityName}列表</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">\${entityName}新建</g:link></span>
        </div>
        <div class="body">
            <h1>\${entityName}明细</h1>
            <g:if test="\${flash.message}">
            <div class="message">\${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    <%  excludedProps = Event.allEvents.toList() << 'version'
                        allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                        props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.each { p -> %>
                        <tr class="prop">
                            <td valign="top" class="name">\${cgDomainProperties.${p.name}.chinese}</td>
                            <%  if (p.isEnum()) { %>
                            <td valign="top" class="value">\${${propertyName}?.${p.name}?.encodeAsHTML()}</td>
                            <%  } else if (p.oneToMany || p.manyToMany) { %>
                            <td valign="top" style="text-align: center;" class="value">
                                <ul>
                                <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                                    <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            <%  } else if (p.manyToOne || p.oneToOne) { %>
                            <td valign="center" class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></td>
                            <%  } else if (p.type == Boolean.class || p.type == boolean.class) { %>
                            <td valign="center" class="value"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></td>
                            <%  } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                            <td valign="center" class="value"><g:formatDate date="\${${propertyName}?.${p.name}}" /></td>
                            <%  } else { %>
                            <td valign="center" class="value">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                            <%  } %>
                        </tr>
                    <%  } %>
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="\${${propertyName}?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="编辑" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="删除" onclick="return confirm('您确定吗')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
