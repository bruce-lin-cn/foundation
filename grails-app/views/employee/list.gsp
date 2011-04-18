
<%@ page import="business.Employee" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'employee.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'employee.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="gender" title="${message(code: 'employee.gender.label', default: 'Gender')}" />
                        
                            <g:sortableColumn property="birthday" title="${message(code: 'employee.birthday.label', default: 'Birthday')}" />
                        
                            <th><g:message code="employee.book.label" default="Book" /></th>
                        
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
                        
                            <td>${fieldValue(bean: employeeInstance, field: "book")}</td>
                        
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
