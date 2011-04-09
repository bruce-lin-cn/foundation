
<%@ page import="business.Employee" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}管理" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">首页</a></span>
            <span class="menuButton"><g:link class="create" action="create">新建${entityName}</g:link></span>
        </div>
        <div class="body">
            <h1>${entityName}列表</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${cgDomainProperties.id.chinese}" />
                        
                            <g:sortableColumn property="name" title="${cgDomainProperties.name.chinese}" />
                        
                            <g:sortableColumn property="gender" title="${cgDomainProperties.gender.chinese}" />
                        
                            <g:sortableColumn property="birthday" title="${cgDomainProperties.birthday.chinese}" />
                        
                            <th><g:message code="employee.company.label" default="Company" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${employeeInstanceList}" status="i" var="employeeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${employeeInstance.id}">${fieldValue(bean: employeeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: employeeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: employeeInstance, field: "gender")}</td>
                        
                            <td><g:formatDate date="${employeeInstance.birthday}" /></td>
                        
                            <td>${fieldValue(bean: employeeInstance, field: "company")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${employeeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
