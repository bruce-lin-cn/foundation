<%@ page import="business.Book" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <title><g:message code="书籍管理" /></title>
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
            {fieldLabel: '字符串1',name: 'string1',xtype: 'textfield', maxLength: 32, maxLengthText: '字符串1至多包含32个字符', minLength: 4, minLengthText: '字符串1至少包含4个字符'},
            {fieldLabel: '字符串2',name: 'string2',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['选择1'],['选择2'],['选择3']]}), emptyText:'请选择字符串2',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '日期1',name: 'date1',xtype:'datefield',format:'Y-m-d'},
            {fieldLabel: '整数1',name: 'ingeger1',xtype:'numberfield'},
            {fieldLabel: '浮点1',name: 'float1',xtype:'numberfield',allowDecimals:true},
            {boxLabel: '真假',name: 'boolean1',xtype:'checkbox'},
            {fieldLabel: '公司',hiddenName: 'company',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'company',emptyText:'请选择公司', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/company/associationListJSON', fields:['id', 'company'],  root: 'root', totalProperty: 'total'})}        ]
    });

    var bookCreateWin = new Ext.Window({
        el: 'bookCreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建书籍',
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
                            Ext.foundation.msg('错误', "创建书籍失败!");
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
            {fieldLabel: '字符串1',name: 'string1',xtype: 'textfield', maxLength: 32, maxLengthText: '字符串1至多包含32个字符', minLength: 4, minLengthText: '字符串1至少包含4个字符'},
            {fieldLabel: '字符串2',name: 'string2',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['选择1'],['选择2'],['选择3']]}), emptyText:'请选择字符串2',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '日期1',name: 'date1',xtype:'datefield',format:'Y-m-d'},
            {fieldLabel: '整数1',name: 'ingeger1',xtype:'numberfield'},
            {fieldLabel: '浮点1',name: 'float1',xtype:'numberfield',allowDecimals:true},
            {boxLabel: '真假',name: 'boolean1',xtype:'checkbox'},
            {fieldLabel: '公司',hiddenName: 'company',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'company',emptyText:'请选择公司', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/company/associationListJSON', fields:['id', 'company'],  root: 'root', totalProperty: 'total'})}
        ]
    });

    var bookUpdateWin = new Ext.Window({
        el: 'bookUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改书籍',
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
                            Ext.foundation.msg('错误', "更新书籍失败!");
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
            {fieldLabel: '字符串1',name: 'string1',xtype: 'textfield', readOnly:true},
            {fieldLabel: '字符串2',name: 'string2',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['选择1'],['选择2'],['选择3']]}), readOnly:true, emptyText:'请选择字符串2',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '日期1',name: 'date1',xtype:'datefield',format:'Y-m-d', readOnly:true},
            {fieldLabel: '整数1',name: 'ingeger1',xtype:'numberfield', readOnly:true},
            {fieldLabel: '浮点1',name: 'float1',xtype:'numberfield',allowDecimals:true, readOnly:true},
            {boxLabel: '真假',name: 'boolean1',xtype:'checkbox', readOnly:true},
            {fieldLabel: '公司',hiddenName: 'company',xtype: 'combo',triggerAction: 'all',valueField: 'id', displayField: 'company',emptyText:'请选择公司', mode: 'remote', store: new Ext.data.JsonStore({url: '/foundation/company/associationListJSON', fields:['id', 'company'],  root: 'root', totalProperty: 'total'}), readOnly:true}
        ]
    });

    var bookDetailWin = new Ext.Window({
        el: 'bookDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '书籍明细',
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
           updateBook();
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
    });

    tb.doLayout();

    var sm = new Ext.grid.CheckboxSelectionModel()
    var cm = new Ext.grid.ColumnModel([
        sm,
        {header:'编号',dataIndex:'id'} ,
        {header:'字符串1',dataIndex:'string1'} ,
        {header:'字符串2',dataIndex:'string2'} ,
        {header:'日期1',dataIndex:'date1', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')} ,
        {header:'整数1',dataIndex:'ingeger1'} ,
        {header:'浮点1',dataIndex:'float1'} ,
        {header:'真假',dataIndex:'boolean1', renderer: function(value){if(value==true)return '是'; else return '否';}} ,
        {header:'公司',dataIndex:'company'}
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
            {name:'boolean1'  } ,
            {name:'company'}
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
        updateBook();
    });

    function updateBook()
    {
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.foundation.msg('注意', "请选择要修改的记录");
        } else {
            bookUpdateForm.getForm().load({
                url:'/foundation/book/detailJSON?id=' + id,
                success:function(form, action) {
                    bookUpdateWin.show();
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
        <div id="bookCreateWin"></div>
        <div id="bookUpdateWin"></div>
        <div id="bookDetailWin"></div>
    </body>
</html>
