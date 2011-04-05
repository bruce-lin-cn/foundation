<%@ page import="business.Book" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <g:set var="entityName" value="${cgDomainProperties.cgChinese}" />
        <title><g:message code="${entityName}管理" /></title>
    </head>
    <script>
Ext.onReady(function(){
    Ext.QuickTips.init();

    var bookCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/book/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '${cgDomainProperties.string1.chinese}',name: 'string1',xtype: 'textfield', maxLength: 32, maxLengthText: '${cgDomainProperties.string1.chinese}至多包含32个字符', minLength: 4, minLengthText: '${cgDomainProperties.string1.chinese}至少包含4个字符'},
            {fieldLabel: '${cgDomainProperties.string2.chinese}',name: 'string2',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['选择1'],['选择2'],['选择3']]}), emptyText:'请选择${cgDomainProperties.string2.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.date1.chinese}',name: 'date1',xtype:'datefield',format:'Y-m-d'},
            {fieldLabel: '${cgDomainProperties.ingeger1.chinese}',name: 'ingeger1',xtype:'numberfield'},
            {fieldLabel: '${cgDomainProperties.float1.chinese}',name: 'float1',xtype:'numberfield',allowDecimals:true},
            {boxLabel: '${cgDomainProperties.boolean1.chinese}',name: 'boolean1',xtype:'checkbox'}
        ]
    });

    var bookCreateWin = new Ext.Window({
        el: 'bookCreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建${entityName}',
        height: 300,
        closeAction: 'hide',
        items: [bookCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    bookCreateForm.getForm().submit({
                        success:function(bookCreateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            bookCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "创建${entityName}失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    bookCreateWin.hide();
                }
            }
        ]
    });

    var bookUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/book/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '${cgDomainProperties.string1.chinese}',name: 'string1',xtype: 'textfield', maxLength: 32, maxLengthText: '${cgDomainProperties.string1.chinese}至多包含32个字符', minLength: 4, minLengthText: '${cgDomainProperties.string1.chinese}至少包含4个字符'},
            {fieldLabel: '${cgDomainProperties.string2.chinese}',name: 'string2',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['选择1'],['选择2'],['选择3']]}), emptyText:'请选择${cgDomainProperties.string2.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.date1.chinese}',name: 'date1',xtype:'datefield',format:'Y-m-d'},
            {fieldLabel: '${cgDomainProperties.ingeger1.chinese}',name: 'ingeger1',xtype:'numberfield'},
            {fieldLabel: '${cgDomainProperties.float1.chinese}',name: 'float1',xtype:'numberfield',allowDecimals:true},
            {boxLabel: '${cgDomainProperties.boolean1.chinese}',name: 'boolean1',xtype:'checkbox'}
        ]
    });

    var bookUpdateWin = new Ext.Window({
        el: 'bookUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改${entityName}',
        height: 300,
        closeAction: 'hide',
        items: [bookUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    bookUpdateForm.getForm().submit({
                        success:function(bookUpdateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            bookUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "更新${entityName}失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    bookUpdateWin.hide();
                }
            }
        ]
    });

    var bookDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/book/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '${cgDomainProperties.string1.chinese}',name: 'string1',xtype: 'textfield', readOnly:true},
            {fieldLabel: '${cgDomainProperties.string2.chinese}',name: 'string2',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['选择1'],['选择2'],['选择3']]}), readOnly:true, emptyText:'请选择${cgDomainProperties.string2.chinese}',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '${cgDomainProperties.date1.chinese}',name: 'date1',xtype:'datefield',format:'Y-m-d', readOnly:true},
            {fieldLabel: '${cgDomainProperties.ingeger1.chinese}',name: 'ingeger1',xtype:'numberfield', readOnly:true},
            {fieldLabel: '${cgDomainProperties.float1.chinese}',name: 'float1',xtype:'numberfield',allowDecimals:true, readOnly:true},
            {boxLabel: '${cgDomainProperties.boolean1.chinese}',name: 'boolean1',xtype:'checkbox', readOnly:true}
        ]
    });

    var bookDetailWin = new Ext.Window({
        el: 'bookDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '${entityName}明细',
        height: 300,
        closeAction: 'hide',
        items: [bookDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    bookDetailWin.hide();
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
            bookCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/foundation/images/skin/database_edit.png',
        handler: function() {
            var id = (grid.getSelectionModel().getSelected()).id;
            if(id==null)
            {
                Ext.foundation.msg('注意', "请选择要修改的记录");
            } else {
                bookUpdateForm.getForm().load({
                    url:'/foundation/book/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.foundation.msg('错误', "服务器出现错误，稍后再试!");
                    }
                });

                bookUpdateWin.show();
            }
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
                            url: '/foundation/book/deleteJSON',
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
                bookDetailForm.getForm().load({
                    url:'/foundation/book/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                bookDetailWin.show();
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
    }
            );

    tb.doLayout();

    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,
        {header:'${cgDomainProperties.id.chinese}',dataIndex:'id'} ,
        {header:'${cgDomainProperties.string1.chinese}',dataIndex:'string1'} ,
        {header:'${cgDomainProperties.string2.chinese}',dataIndex:'string2'} ,
        {header:'${cgDomainProperties.date1.chinese}',dataIndex:'date1', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')} ,
        {header:'${cgDomainProperties.ingeger1.chinese}',dataIndex:'ingeger1'} ,
        {header:'${cgDomainProperties.float1.chinese}',dataIndex:'float1'} ,
        {header:'${cgDomainProperties.boolean1.chinese}',dataIndex:'boolean1', renderer: function(value){if(value==true)return '是'; else return '否';}} 
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/foundation/book/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [
            
            {name:'id'  } ,
            {name:'string1'  } ,
            {name:'string2'  } ,
            {name:'date1' , type:'date', dateFormat:'c' } ,
            {name:'ingeger1'  } ,
            {name:'float1'  } ,
            {name:'boolean1'  } 
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
});
    </script>
    <body>
        <div id="toolbar"></div>
        <div id="grid"></div>
        <div id="bookCreateWin"></div>
        <div id="bookUpdateWin"></div>
        <div id="bookDetailWin"></div>
    </body>
</html>
