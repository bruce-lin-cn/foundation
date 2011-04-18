

<%@ page import="business.Employee" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${employeeInstance}">
            <div class="errors">
                <g:renderErrors bean="${employeeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${employeeInstance?.id}" />
                <g:hiddenField name="version" value="${employeeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="employee.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="32" value="${employeeInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gender"><g:message code="employee.gender.label" default="Gender" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'gender', 'errors')}">
                                    <g:select name="gender" from="${employeeInstance.constraints.gender.inList}" value="${employeeInstance?.gender}" valueMessagePrefix="employee.gender"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="birthday"><g:message code="employee.birthday.label" default="Birthday" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'birthday', 'errors')}">
                                    <g:datePicker name="birthday" chinese="生日" precision="day" value="${employeeInstance?.birthday}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="book"><g:message code="employee.book.label" default="Book" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'book', 'errors')}">
                                    <g:select name="book.id" from="${business.Book.list()}" optionKey="id" value="${employeeInstance?.book?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="company"><g:message code="employee.company.label" default="Company" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'company', 'errors')}">
                                    <g:select name="company.id" from="${business.Company.list()}" optionKey="id" value="${employeeInstance?.company?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
