

<%@ page import="business.Book" %>
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
            <g:hasErrors bean="${bookInstance}">
            <div class="errors">
                <g:renderErrors bean="${bookInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${bookInstance?.id}" />
                <g:hiddenField name="version" value="${bookInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="string1">${cgDomainProperties.string1.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bookInstance, field: 'string1', 'errors')}">
                                    <g:textField name="string1" maxlength="32" value="${bookInstance?.string1}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="string2">${cgDomainProperties.string2.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bookInstance, field: 'string2', 'errors')}">
                                    <g:textField name="string2" value="${bookInstance?.string2}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="string3">${cgDomainProperties.string3.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bookInstance, field: 'string3', 'errors')}">
                                    <g:select name="string3" from="${bookInstance.constraints.string3.inList}" value="${bookInstance?.string3}" valueMessagePrefix="book.string3"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="date1">${cgDomainProperties.date1.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bookInstance, field: 'date1', 'errors')}">
                                    <g:datePicker name="date1" chinese="日期1" format="Date" precision="day" value="${bookInstance?.date1}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="date2">${cgDomainProperties.date2.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bookInstance, field: 'date2', 'errors')}">
                                    <g:datePicker name="date2" chinese="日期2" format="Date" precision="day" value="${bookInstance?.date2}"  />
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
