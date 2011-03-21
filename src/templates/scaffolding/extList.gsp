<% import grails.persistence.Event %>
<%=packageName%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <g:set var="entityName" value="\${cgDomainProperties.cgChinese}" />
        <title><g:message code="\${entityName}管理" /></title>
    
    </head>

    <script>
        Ext.onReady(function(){
            var cbsm= new Ext.grid.CheckboxSelectionModel()
            var cm = new Ext.grid.ColumnModel([
            cbsm,
            <%  excludedProps = Event.allEvents.toList() << 'version'
            allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
            props.eachWithIndex { p, i ->
                if (i < 10) {
                    if (p.isAssociation()) { %><%      } else { %>
                {header:'\${cgDomainProperties.${p.name}.chinese}',dataIndex:'${p.name}'} <% if(props.size()>i+1){out<<","} %><%  }   }   } %>
            ]);

            var data=[
                    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                        [<%  props.eachWithIndex { p, i -> %>'\${fieldValue(bean: ${propertyName}, field: "${p.name}")}'<% if(props.size()>i+1){out<<","} %><%}%>]<g:if test="\${${propertyName}List.size() > i +1}">,</g:if>
                    </g:each>
             ];

            var store= new Ext.data.Store({
                proxy: new Ext.data.MemoryProxy(data),
                reader: new Ext.data.ArrayReader({},[<%  props.eachWithIndex { p, i ->
                                if (i < 10) {
                                    if (p.isAssociation()) { %><%      } else { %>
                    {name:'${p.name}'}<% if(props.size()>i+1){out<<","} %><%  }   }   } %>
                ])
            });

            var grid= new Ext.grid.GridPanel({
                renderTo: 'grid',
                store: store,
                enableColumnMove:false,
                enableColumnResize:false,
                stripeRows:true,
                loadMask:true,
                cm: cm,
                sm: new Ext.grid.RowSelectionModel({singleSelect:false}),
                autoHeight: true,

                viewConfig: {
                    forceFit:true
                },

                bbar: new Ext.PagingToolbar({
                    pageSize: 10,
                    store: store,
                    displayInfo: true,
                    displayMsg: '显示第{0}条到第{1}条记录, 共{2}条',
                    emptyMsg: "没有记录"
                })
            });

            store.load();
        });
    </script>
    <body>
        <div id="grid"></div>
    </body>
</html>
