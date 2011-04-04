

<%@ page import="business.Book" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}创建" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">首页</a></span>
            <span class="menuButton"><g:link class="list" action="list">${entityName}列表</g:link></span>
        </div>
        <div class="body">
            <h1>创建${entityName}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${bookInstance}">
            <div class="errors">
                <g:renderErrors bean="${bookInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
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
                                    <g:select name="string2" from="${bookInstance.constraints.string2.inList}" value="${bookInstance?.string2}" valueMessagePrefix="book.string2"  />
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
                                    <label for="ingeger1">${cgDomainProperties.ingeger1.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bookInstance, field: 'ingeger1', 'errors')}">
                                    <g:textField name="ingeger1" value="${fieldValue(bean: bookInstance, field: 'ingeger1')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="float1">${cgDomainProperties.float1.chinese}</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bookInstance, field: 'float1', 'errors')}">
                                    <g:textField name="float1" value="${fieldValue(bean: bookInstance, field: 'float1')}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="创建" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
