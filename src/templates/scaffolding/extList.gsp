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
            // 创建工具条
            var tb = new Ext.Toolbar();
            tb.render('toolbar');

            tb.add({
                text: '新建',
                icon: '/foundation/images/skin/database_add.png'
            },{
                text: '修改',
                icon: '/foundation/images/skin/database_edit.png'
            },{
                text: '删除',
                icon: '/foundation/images/skin/database_delete.png',
                handler: function(){
                    var id = (grid.getSelectionModel().getSelected()).id;
                    if (id){
                        Ext.Ajax.request({
                            url: '/foundation/${domainClass.propertyName}/extDelete?id='+id,
                            success: function(result){
                                var json_str = Ext.util.JSON.decode(result.responseText);
                                Ext.Msg.alert('信息',json_str.msg);
                                    store.reload();
                            },
                            failure:function(){
                                //Ext.Msg.alert('信息','服务器出现错误，稍后再试!');
                            }
                        });
                    }
                }
            },{
                text: '详细',
                icon: '/foundation/images/skin/database_save.png'
            },
            '->',
            {
                xtype: 'textfield',
                name: 'searchBar',
                emptyText: '请输入搜索条件'
            },{
                text: '搜索',
                icon: '/foundation/images/skin/database_search.png'
            });

            tb.doLayout();

            var cbsm= new Ext.grid.CheckboxSelectionModel()
            var cm = new Ext.grid.ColumnModel([
            cbsm,<%  excludedProps = Event.allEvents.toList() << 'version'
            allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
            props.eachWithIndex { p, i ->
                if (i < 10) {
                    if (p.isAssociation()) { %><%      } else { %>
                {header:'\${cgDomainProperties.${p.name}.chinese}',dataIndex:'${p.name}'} <% if(props.size()>i+1){out<<","} %><%  }   }   } %>
            ]);

            var store= new Ext.data.Store({
                autoLoad:true,
                proxy: new Ext.data.HttpProxy({url:'/foundation/${domainClass.propertyName}/listJSON'}),
                reader: new Ext.data.JsonReader({
                    totalProperty:'total',
                    root:'root'
                },[<%  props.eachWithIndex { p, i ->
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

            store.load({params:{start:0,limit:10}});
        });
    </script>
    <body>
        <div id="toolbar"></div>
        <div id="grid"></div>
    </body>
</html>
