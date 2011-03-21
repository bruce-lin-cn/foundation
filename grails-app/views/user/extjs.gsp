
<%@ page import="platform.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}管理" /></title>
    </head>
    <script>
        Ext.onReady(function(){
            //Ext.MessageBox.alert('${entityName}','${entityName}');
            var cm = new Ext.grid.ColumnModel([

                {header:'编号',dataIndex:'id'},
                {header:'姓名',dataIndex:'name'},
                {header:'手机',dataIndex:'mobile'},
                {header:'身份证号',dataIndex:'identityCardNum'}
            ]);

            var data=[
                ['1','林禹','18906057051','350105197901182331'],
                ['2','周良','18906057052','350105197901182332'],
                ['3','孟丽珠','18906057053','350105197901182333']
            ];

            var store= new Ext.data.Store({
                proxy: new Ext.data.MemoryProxy(data),
                reader: new Ext.data.ArrayReader({},[
                    {name:'id'},
                    {name:'name'},
                    {name:'mobile'},
                    {name:'identityCardNum'}
                ])
            });

            store.load();

            var grid= new Ext.grid.GridPanel({
                renderTo: 'grid',
                store: store,
                cm: cm,
                height: 200
            });
        });
    </script>
    <body>

        <div class="body">
            <h1>${entityName}列表</h1>
            <div id="grid"></div>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${cgDomainProperties.id.chinese}" />
                        
                            <g:sortableColumn property="name" title="${cgDomainProperties.name.chinese}" />
                        
                            <g:sortableColumn property="mobile" title="${cgDomainProperties.mobile.chinese}" />
                        
                            <g:sortableColumn property="identityCardNum" title="${cgDomainProperties.identityCardNum.chinese}" />
                        
                            <g:sortableColumn property="dateCreated" title="${cgDomainProperties.dateCreated.chinese}" />
                        
                            <g:sortableColumn property="lastUpdated" title="${cgDomainProperties.lastUpdated.chinese}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userInstanceList}" status="i" var="userInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: userInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "mobile")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "identityCardNum")}</td>
                        
                            <td><g:formatDate   dateStyle="yyyy-MM-dd"  date="${userInstance.dateCreated}" /></td>
                        
                            <td><g:formatDate date="${userInstance.lastUpdated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${userInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
