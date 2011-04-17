<% import grails.persistence.Event %><% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %><%=packageName%>
<%
    cgConstraints=domainClass.getConstrainedProperties()
    cgDomainProperties=[:]
    hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')

    cgDomainProperties.cgDomain=domainClass.clazz.cgDomain

    excludedProps = Event.allEvents.toList() << 'version'
    allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
    props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))

    props.each { p ->
        if (!Collection.class.isAssignableFrom(p.type)) {
            if (hasHibernate) {
                cp = domainClass.constrainedProperties[p.name]
            }
            if (p.name!='version') {
                def map=[:]
                if(p.isAssociation())
                {
                    map.chinese=p.getReferencedDomainClass().clazz.cgDomain.chinese
                    map.association=true
                    cgDomainProperties[p.name]=map
                }else if(p.name=='id'){
                    map.chinese='编号'
                    map.association=false
                    cgDomainProperties[p.name]=map
                }else if(p.name=='dateCreated'){
                    map.chinese='创建时间'
                    map.association=false
                    cgDomainProperties[p.name]=map
                }else if(p.name=='lastUpdated'){
                    map.chinese='最近更新'
                    map.association=false
                    cgDomainProperties[p.name]=map
                }else{
                    map.chinese=domainClass.getConstrainedProperties()[p.name].attributes.chinese
                    map.association=false
                    cgDomainProperties[p.name]=map
                }

                cgDomainProperties[p.name]=map
            }
        }
    }

    def output(p,cp,i, mode)
    {
        //对齐
        if(i!=0)
        {
            out << "            "
        }
        if (cp.inList != null) {
            out << "{fieldLabel: '${cgDomainProperties[p.name].chinese}',name: '${p.name}',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:["
            for(int j=0;j<cp.inList.size();j++)
            {
                out << "['${cp.inList[j]}']"
                if(j< cp.inList.size()-1)
                {
                    out << ","
                }
            }
            out <<"]})"
            if("detail".compareTo(mode)==0)
            {
                out << ", readOnly:true"
            }
            out <<", emptyText:'请选择${cgDomainProperties[p.name].chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'}"
        } else if (p.type == String.class) {
            out << "{fieldLabel: '${cgDomainProperties[p.name].chinese}',name: '${p.name}',xtype: 'textfield'"

            if("detail".compareTo(mode)==0)
            {
                out << ", readOnly:true"
            }else {
                if (cp.blank == false) {
                    out << ", allowBlank: false, blankText: '${cgDomainProperties[p.name].chinese}为必填项'"
                }
                if (cp.maxSize != null) {
                    out << ", maxLength: ${cp.maxSize}, maxLengthText: '${cgDomainProperties[p.name].chinese}至多包含${cp.maxSize}个字符'"
                }
                if (cp.minSize != null) {
                    out << ", minLength: ${cp.minSize}, minLengthText: '${cgDomainProperties[p.name].chinese}至少包含${cp.minSize}个字符'"
                }
            }

            out << "}"
        } else if (p.type == Date.class) {
            out << "{fieldLabel: '${cgDomainProperties[p.name].chinese}',name: '${p.name}',xtype:'datefield',format:'Y-m-d'"
            if("detail".compareTo(mode)==0)
            {
                out << ", readOnly:true"
            }
            out << "}"
        }else if (p.type == int) {
            out << "{fieldLabel: '${cgDomainProperties[p.name].chinese}',name: '${p.name}',xtype:'numberfield'"
            if("detail".compareTo(mode)==0)
            {
                out << ", readOnly:true"
            }
            out << "}"
        }else if (p.type == float) {
            out << "{fieldLabel: '${cgDomainProperties[p.name].chinese}',name: '${p.name}',xtype:'numberfield',allowDecimals:true"
            if("detail".compareTo(mode)==0)
            {
                out << ", readOnly:true"
            }
            out << "}"
        }else if (p.type == boolean){
            out << "{boxLabel: '${cgDomainProperties[p.name].chinese}',name: '${p.name}',xtype:'checkbox'"
            if("detail".compareTo(mode)==0)
            {
                out << ", readOnly:true"
            }
            out << "}"
        }else if(p.isAssociation() && p.oneToOne){
            out << "{fieldLabel: '${cgDomainProperties[p.name].chinese}',hiddenName: '${p.name}',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: '${p.name}',emptyText:'请选择${cgDomainProperties[p.name].chinese}', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/${p.name}/associationListJSON', fields:['id', '${p.name}'],  root: 'root', totalProperty: 'total'})"
            if("detail".compareTo(mode)==0)
            {
                out << ", readOnly:true"
            }
            out << "}"
        } else{
            // 未处理的
            out << p
            println ""
        }
        if (props.size() > i + 1) {
            out << ","
            println ""
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title><g:message code="${cgDomainProperties.cgDomain.chinese}管理" /></title>
    </head>
    <script>
Ext.onReady(function(){
    Ext.QuickTips.init();

    var ${domainClass.propertyName}CreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/${domainClass.propertyName}/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            <% excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
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
                               if (display) {
                                output(p,cp,i,"create")
                               }
                        }
                    }
%>        ]
    });

    var ${domainClass.propertyName}CreateWin = new Ext.Window({
        el: '${domainClass.propertyName}CreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建${cgDomainProperties.cgDomain.chinese}',
        height: 300,
        closeAction: 'hide',
        items: [${domainClass.propertyName}CreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    ${domainClass.propertyName}CreateForm.getForm().submit({
                        success:function(${domainClass.propertyName}CreateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            ${domainClass.propertyName}CreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "创建${cgDomainProperties.cgDomain.chinese}失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    ${domainClass.propertyName}CreateWin.hide();
                }
            }
        ]
    });

    var ${domainClass.propertyName}UpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/${domainClass.propertyName}/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            <%  excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
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
                               if (display) {
                                output(p,cp,i,"update")
                            }
                        }
                    }
%>
        ]
    });

    var ${domainClass.propertyName}UpdateWin = new Ext.Window({
        el: '${domainClass.propertyName}UpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改${cgDomainProperties.cgDomain.chinese}',
        height: 300,
        closeAction: 'hide',
        items: [${domainClass.propertyName}UpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    ${domainClass.propertyName}UpdateForm.getForm().submit({
                        success:function(${domainClass.propertyName}UpdateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            ${domainClass.propertyName}UpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "更新${cgDomainProperties.cgDomain.chinese}失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    ${domainClass.propertyName}UpdateWin.hide();
                }
            }
        ]
    });

    var ${domainClass.propertyName}DetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/${domainClass.propertyName}/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            <%  excludedProps = Event.allEvents.toList() << 'version' << 'id'
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
                               if (display) {
                                output(p,cp,i,"detail")
                            }
                        }
                    }
%>
        ]
    });

    var ${domainClass.propertyName}DetailWin = new Ext.Window({
        el: '${domainClass.propertyName}DetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '${cgDomainProperties.cgDomain.chinese}明细',
        height: 300,
        closeAction: 'hide',
        items: [${domainClass.propertyName}DetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    ${domainClass.propertyName}DetailWin.hide();
                }
            }
        ]
    });

    var tb = new Ext.Toolbar();
    tb.render('toolbar');

    tb.add({
        text: '新建',
        icon: '/foundation/images/skin/database_add.png',
        handler:function() {
            ${domainClass.propertyName}CreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/foundation/images/skin/database_edit.png',
        handler: function() {
           update${className}();
        }
    }, {
        text: '删除',
        icon: '/foundation/images/skin/database_delete.png',
        handler: function() {
            var count = sm.getCount();
            if (count == 0) {
                Ext.foundation.msg('注意', "请选择要删除的记录");
            } else {
                var records = sm.getSelections();
                var id = [];
                for (var i = 0; i < count; i++) {
                    id.push(records[i].id);
                }
                Ext.MessageBox.confirm('信息', '您确定删除编号为' + id + '的记录吗?', function(btn) {
                    if (btn == 'yes') {
                        Ext.Ajax.request({
                            url: '/foundation/${domainClass.propertyName}/deleteJSON',
                            params: {id:id},
                            success: function(result) {
                                var json_str = Ext.util.JSON.decode(result.responseText);
                                Ext.foundation.msg('信息', json_str.msg);
                                store.reload();
                            },
                            failure:function() {
                                Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                            }
                        });
                    }
                });

            }
        }
    }, {
        text: '详细',
        icon: '/foundation/images/skin/database_save.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if (id == null) {
                Ext.foundation.msg('注意', "请选择要显示的记录");
            }else{
                ${domainClass.propertyName}DetailForm.getForm().load({
                    url:'/foundation/${domainClass.propertyName}/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                ${domainClass.propertyName}DetailWin.show();
            }
        }
    },{
        text: '导入',
        icon: '/foundation/images/skin/database_add.png',
        handler:function() {

        }
    },{
        text: '更多',
        icon: '/foundation/images/skin/database_add.png',
        handler:function() {

        }
    }, '->',
    {
        xtype: 'textfield',
        name: 'searchBar',
        emptyText: '请输入搜索条件'
    }, {
        text: '搜索',
        icon: '/foundation/images/skin/database_search.png',
        handler: function() {
        }
    });

    tb.doLayout();

    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,<%  excludedProps = Event.allEvents.toList() << 'version'
       allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
       props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
       Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
       props.eachWithIndex { p, i ->
           if (i < 10) {
               if (p.isAssociation()) { %>
        {header:'${cgDomainProperties[p.name].chinese}',dataIndex:'${p.name}'}<% if(props.size()>i+1){out<<","}} else { %>
        {header:'${cgDomainProperties[p.name].chinese}',dataIndex:'${p.name}'<%
            if(p.type==boolean){
                out << ", renderer: function(value){if(value==true)return '是'; else return '否';}"
            }else if(p.type==Date.class){
                out<<", type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')"
            } %>} <% if(props.size()>i+1){out<<","} %><%  }   }   } %>
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/foundation/${domainClass.propertyName}/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [<%  props.eachWithIndex { p, i ->
                           if (i < 10) {
                               if (p.isAssociation()) { %>
            {name:'${p.name}'}<% if(props.size()>i+1){out<<","} %><%      } else { %>
            {name:'${p.name}' <% if(p.type==Date.class){out<<", type:'date', dateFormat:'c'"} %> } <% if(props.size()>i+1){out<<","} %><%  }   }   } %>
        ])
    });

    var grid = new Ext.grid.GridPanel({
        renderTo: 'grid',
        store: store,
        enableColumnMove:false,
        enableColumnResize:true,
        stripeRows:true,
        enableHdMenu: false,
        trackMouseOver: true,
        loadMask:true,
        cm: cm,
        sm: sm,
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
    grid.on('dblclick', function(e) {
        update${className}();
    });

    function update${className}()
    {
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.foundation.msg('注意', "请选择要修改的记录");
        } else {
            ${domainClass.propertyName}UpdateForm.getForm().load({
                url:'/foundation/${domainClass.propertyName}/detailJSON?id=' + id,
                success:function(form, action) {
                    ${domainClass.propertyName}UpdateWin.show();
                },
                failure:function() {
                    Ext.foundation.msg('错误', "服务器出现错误，稍后再试!");
                }
            });
        }
    }

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
