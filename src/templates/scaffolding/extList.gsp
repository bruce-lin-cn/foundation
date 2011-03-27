<% import grails.persistence.Event %>
<% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %>
<%=packageName%>
<% boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate') %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <g:set var="entityName" value="\${cgDomainProperties.cgChinese}" />
        <title><g:message code="\${entityName}管理" /></title>
    
    </head>

    <script>
        Ext.QuickTips.init();
        Ext.onReady(function(){

            var ${domainClass.propertyName}CreateForm = new Ext.form.FormPanel({
                labelAlign: 'right',
                labelWidth: 80,
                frame: true,
                url: '/foundation/${domainClass.propertyName}/createJSON',
                defaultType: 'textfield',
                items: [
                    {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},<%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
                    persistentPropNames = domainClass.persistentProperties*.name
                    props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
                    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                    display = true
                    props.eachWithIndex { p, i ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
                                    if (hasHibernate) {
                                        cp = domainClass.constrainedProperties[p.name]
                                        display = (cp ? cp.display : true)
                                    }
                                    if (display) { %>
                    {fieldLabel: '\${cgDomainProperties.${p.name}.chinese}',name: '${p.name}',xtype: <% if(p.type==String.class){ out << "'textfield'"} else if(p.type==Date.class){ out << "'datefield',format:'Y-m-d'"}%>}<% if(props.size()>i+1){out<<","} %><%  }   }   } %>
                ]
            });

            var ${domainClass.propertyName}CreateWin = new Ext.Window({
                el: '${domainClass.propertyName}CreateWin',
                closable:false,
                layout: 'fit',
                width: 400,
                title: '创建\${entityName}',
                height: 300,
                closeAction: 'hide',
                items: [${domainClass.propertyName}CreateForm],
                buttons: [{
                    text:'创建',
                    handler: function(){
                        ${domainClass.propertyName}CreateForm.getForm().submit({
                            success:function(${domainClass.propertyName}CreateForm, action){
                                Ext.Msg.alert('信息',action.result.msg);
                                ${domainClass.propertyName}CreateWin.hide();
                                store.reload();
                                },
                            failure:function(){
                                Ext.Msg.alert('信息',"创建\${entityName}失败!");}
                        });
                    }
                },{
                    text: '取 消',
                    handler: function(){
                        ${domainClass.propertyName}CreateWin.hide();
                    }
                }]
            });

            var ${domainClass.propertyName}UpdateForm = new Ext.form.FormPanel({
                labelAlign: 'right',
                labelWidth: 80,
                frame: true,
                url: '/foundation/${domainClass.propertyName}/updateJSON',
                defaultType: 'textfield',
                items: [
                    {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},<%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
                    persistentPropNames = domainClass.persistentProperties*.name
                    props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
                    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                    display = true
                    props.eachWithIndex { p, i ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
                                    if (hasHibernate) {
                                        cp = domainClass.constrainedProperties[p.name]
                                        display = (cp ? cp.display : true)
                                    }
                                    if (display) { %>
                    {fieldLabel: '\${cgDomainProperties.${p.name}.chinese}',name: '${p.name}',xtype: <% if(p.type==String.class){ out << "'textfield'"} else if(p.type==Date.class){ out << "'datefield',format:'Y-m-d'"}%>}<% if(props.size()>i+1){out<<","} %><%  }   }   } %>
                ]
            });

            var ${domainClass.propertyName}UpdateWin = new Ext.Window({
                el: '${domainClass.propertyName}UpdateWin',
                closable:false,
                layout: 'fit',
                width: 400,
                title: '修改\${entityName}',
                height: 300,
                closeAction: 'hide',
                items: [${domainClass.propertyName}UpdateForm],
                buttons: [{
                    text:'更新',
                    handler: function(){
                        ${domainClass.propertyName}UpdateForm.getForm().submit({
                            success:function(${domainClass.propertyName}UpdateForm, action){
                                Ext.Msg.alert('信息',action.result.msg);
                                ${domainClass.propertyName}UpdateWin.hide();
                                store.reload();
                                },
                            failure:function(){
                                Ext.Msg.alert('信息',"更新\${entityName}失败!");}
                        });
                    }
                },{
                    text: '取 消',
                    handler: function(){
                        ${domainClass.propertyName}UpdateWin.hide();
                    }
                }]
            });

            var ${domainClass.propertyName}DetailForm = new Ext.form.FormPanel({
                labelAlign: 'right',
                labelWidth: 80,
                frame: true,
                url: '/foundation/${domainClass.propertyName}/detailJSON',
                defaultType: 'textfield',
                items: [
                    {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},<%  excludedProps = Event.allEvents.toList() << 'version' << 'id'
                    persistentPropNames = domainClass.persistentProperties*.name
                    props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
                    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                    display = true
                    props.eachWithIndex { p, i ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
                                    if (hasHibernate) {
                                        cp = domainClass.constrainedProperties[p.name]
                                        display = (cp ? cp.display : true)
                                    }
                                    if (display) { %>
                    {fieldLabel: '\${cgDomainProperties.${p.name}.chinese}',name: '${p.name}',readOnly: true, xtype: <% if(p.type==String.class){ out << "'textfield'"} else if(p.type==Date.class){ out << "'datefield',format:'Y-m-d'"}%>}<% if(props.size()>i+1){out<<","} %><%  }   }   } %>
                ]
            });

            var ${domainClass.propertyName}DetailWin = new Ext.Window({
                el: '${domainClass.propertyName}DetailWin',
                closable:false,
                layout: 'fit',
                width: 400,
                title: '\${entityName}明细',
                height: 300,
                closeAction: 'hide',
                items: [${domainClass.propertyName}DetailForm],
                buttons: [{
                    text: '确定',
                    handler: function(){
                        ${domainClass.propertyName}DetailWin.hide();
                    }
                }]
            });

            var tb = new Ext.Toolbar();
            tb.render('toolbar');

            tb.add({
                text: '新建',
                icon: '/foundation/images/skin/database_add.png',
                handler:function(){
                    ${domainClass.propertyName}CreateWin.show(this);
                }
            },{
                text: '修改',
                icon: '/foundation/images/skin/database_edit.png',
                handler: function(){
                    var id = (grid.getSelectionModel().getSelected()).id;
                    ${domainClass.propertyName}UpdateForm.getForm().load({
                        url:'/foundation/${domainClass.propertyName}/detailJSON?id='+id,
                        success:function(form,action){},
                        failure:function(){
                            Ext.Msg.alert('信息','服务器出现错误，稍后再试!');
                        }
                    });

                    customerUpdateWin.show();
                }
            },{
                text: '删除',
                icon: '/foundation/images/skin/database_delete.png',
                handler: function(){
                    var id = (grid.getSelectionModel().getSelected()).id;
                    if (id){
                        Ext.Ajax.request({
                            url: '/foundation/${domainClass.propertyName}/deleteJSON?id='+id,
                            success: function(result){
                                var json_str = Ext.util.JSON.decode(result.responseText);
                                Ext.Msg.alert('信息',json_str.msg);
                                    store.reload();
                            },
                            failure:function(){
                                Ext.Msg.alert('信息','服务器出现错误，稍后再试!');
                            }
                        });
                    }
                }
            },{
                text: '详细',
                icon: '/foundation/images/skin/database_save.png',
                handler: function(){
                    var id = (grid.getSelectionModel().getSelected()).id;
                    ${domainClass.propertyName}DetailForm.getForm().load({
                        url:'/foundation/${domainClass.propertyName}/detailJSON?id='+id,
                        success:function(form,action){},
                        failure:function(){
                            Ext.Msg.alert('信息','服务器出现错误，稍后再试!');
                        }
                    });

                    customerDetailWin.show();
                }
            },'->',
            {
                xtype: 'textfield',
                name: 'searchBar',
                emptyText: '请输入搜索条件'
            },{
                text: '搜索',
                icon: '/foundation/images/skin/database_search.png',
                handler: function(){

                }
            }
            );

            tb.doLayout();

            var cbsm= new Ext.grid.CheckboxSelectionModel({singleSelect:false})
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
                height: 270,

                viewConfig: {
                    forceFit:true
                },

                bbar: new Ext.PagingToolbar({
                    pageSize: 10,
                    store: store,
                    displayInfo: true,
                    displayMsg: '显示第{0}条到第{1}条记录, 共{2}条',
                    emptyMsg: '没有记录'
                })
            });

            store.load({params:{start:0,limit:10}});
        });



    </script>
    <body>
        <div id="toolbar"></div>
        <div id="grid"></div>
        <div id="${domainClass.propertyName}CreateWin"></div>
        <div id="${domainClass.propertyName}UpdateWin"></div>
        <div id="${domainClass.propertyName}DetailWin"></div>
    </body>
</html>
