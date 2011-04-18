
<%@ page import="business.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'customer.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'customer.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="gender" title="${message(code: 'customer.gender.label', default: 'Gender')}" />
                        
                            <g:sortableColumn property="mobile" title="${message(code: 'customer.mobile.label', default: 'Mobile')}" />
                        
                            <g:sortableColumn property="identityCardNum" title="${message(code: 'customer.identityCardNum.label', default: 'Identity Card Num')}" />
                        
                            <g:sortableColumn property="level" title="${message(code: 'customer.level.label', default: 'Level')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerInstanceList}" status="i" var="customerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "gender")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "mobile")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "identityCardNum")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "level")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
