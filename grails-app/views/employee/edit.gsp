

<%@ page import="business.Employee" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}更新" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">首页</a></span>
            <span class="menuButton"><g:link class="list" action="list">${entityName}列表</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">${entityName}新建</g:link></span>
        </div>
        <div class="body">
            <h1>${entityName}编辑</h1>
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
                                  <label for="name">${cgDomainProperties.name.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="32" value="${employeeInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="gender">${cgDomainProperties.gender.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'gender', 'errors')}">
                                    <g:select name="gender" from="${employeeInstance.constraints.gender.inList}" value="${employeeInstance?.gender}" valueMessagePrefix="employee.gender"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="birthday">${cgDomainProperties.birthday.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'birthday', 'errors')}">
                                    <g:datePicker name="birthday" chinese="生日" precision="day" value="${employeeInstance?.birthday}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="book">${cgDomainProperties.book.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'book', 'errors')}">
                                    <g:select name="book.id" from="${business.Book.list()}" optionKey="id" value="${employeeInstance?.book?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="company">${cgDomainProperties.company.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'company', 'errors')}">
                                    <g:select name="company.id" from="${business.Company.list()}" optionKey="id" value="${employeeInstance?.company?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="更新" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="删除" onclick="return confirm('您确定吗?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
