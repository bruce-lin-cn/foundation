<%@ page import="business.Customer" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:extjs />
        <title><g:message code="客户管理" /></title>
    </head>
    <script>
Ext.onReady(function(){
    Ext.QuickTips.init();

    var customerCreateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/customer/createJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 32, maxLengthText: '姓名至多包含32个字符', minLength: 2, minLengthText: '姓名至少包含2个字符'},
            {fieldLabel: '性别',name: 'gender',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['男'],['女']]}), emptyText:'请选择性别',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '手机',name: 'mobile',xtype: 'textfield', allowBlank: false, blankText: '手机为必填项', maxLength: 11, maxLengthText: '手机至多包含11个字符', minLength: 11, minLengthText: '手机至少包含11个字符'},
            {fieldLabel: '身份证号',name: 'identityCardNum',xtype: 'textfield', maxLength: 18, maxLengthText: '身份证号至多包含18个字符', minLength: 18, minLengthText: '身份证号至少包含18个字符'},
            {fieldLabel: '等级',name: 'level',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['普通'],['高级'],['VIP']]}), emptyText:'请选择等级',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '余额',name: 'balance',xtype: 'textfield'},
            {fieldLabel: '生日',name: 'birthday',xtype: 'textfield'}        ]
    });

    var customerCreateWin = new Ext.Window({
        el: 'customerCreateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '创建客户',
        height: 300,
        closeAction: 'hide',
        items: [customerCreateForm],
        buttons: [
            {
                text:'创建',
                handler: function() {
                    customerCreateForm.getForm().submit({
                        success:function(customerCreateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            customerCreateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "创建客户失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    customerCreateWin.hide();
                }
            }
        ]
    });

    var customerUpdateForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/customer/updateJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', allowBlank: false, blankText: '姓名为必填项', maxLength: 32, maxLengthText: '姓名至多包含32个字符', minLength: 2, minLengthText: '姓名至少包含2个字符'},
            {fieldLabel: '性别',name: 'gender',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['男'],['女']]}), emptyText:'请选择性别',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '手机',name: 'mobile',xtype: 'textfield', allowBlank: false, blankText: '手机为必填项', maxLength: 11, maxLengthText: '手机至多包含11个字符', minLength: 11, minLengthText: '手机至少包含11个字符'},
            {fieldLabel: '身份证号',name: 'identityCardNum',xtype: 'textfield', maxLength: 18, maxLengthText: '身份证号至多包含18个字符', minLength: 18, minLengthText: '身份证号至少包含18个字符'},
            {fieldLabel: '等级',name: 'level',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['普通'],['高级'],['VIP']]}), emptyText:'请选择等级',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '余额',name: 'balance',xtype: 'textfield'},
            {fieldLabel: '生日',name: 'birthday',xtype: 'textfield'}
        ]
    });

    var customerUpdateWin = new Ext.Window({
        el: 'customerUpdateWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '修改客户',
        height: 300,
        closeAction: 'hide',
        items: [customerUpdateForm],
        buttons: [
            {
                text:'更新',
                handler: function() {
                    customerUpdateForm.getForm().submit({
                        success:function(customerUpdateForm, action) {
                            Ext.foundation.msg('信息', action.result.msg);
                            customerUpdateWin.hide();
                            store.reload();
                        },
                        failure:function() {
                            Ext.foundation.msg('错误', "更新客户失败!");
                        }
                    });
                }
            },
            {
                text: '取 消',
                handler: function() {
                    customerUpdateWin.hide();
                }
            }
        ]
    });

    var customerDetailForm = new Ext.form.FormPanel({
        labelAlign: 'right',
        labelWidth: 80,
        frame: true,
        url: '/foundation/customer/detailJSON',
        defaults:{ width:250},
        items: [
            {fieldLabel:'id',name: 'id',xtype: 'numberfield',hidden:true,hideLabel:true},
            {fieldLabel: '姓名',name: 'name',xtype: 'textfield', readOnly:true},
            {fieldLabel: '性别',name: 'gender',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['男'],['女']]}), readOnly:true, emptyText:'请选择性别',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '手机',name: 'mobile',xtype: 'textfield', readOnly:true},
            {fieldLabel: '身份证号',name: 'identityCardNum',xtype: 'textfield', readOnly:true},
            {fieldLabel: '等级',name: 'level',xtype: 'combo',store: new Ext.data.SimpleStore({ fields:['values'], data:[['普通'],['高级'],['VIP']]}), readOnly:true, emptyText:'请选择等级',mode: 'local', triggerAction: 'all', valueField: 'values', displayField: 'values'},
            {fieldLabel: '余额',name: 'balance',xtype: 'textfield', readOnly:true},
            {fieldLabel: '生日',name: 'birthday',xtype: 'textfield', readOnly:true},
            {fieldLabel: '创建时间',name: 'dateCreated',xtype:'datefield',format:'Y-m-d', readOnly:true},
            {fieldLabel: '最近更新',name: 'lastUpdated',xtype:'datefield',format:'Y-m-d', readOnly:true}
        ]
    });

    var customerDetailWin = new Ext.Window({
        el: 'customerDetailWin',
        closable:false,
        layout: 'fit',
        width: 400,
        title: '客户明细',
        height: 300,
        closeAction: 'hide',
        items: [customerDetailForm],
        buttons: [
            {
                text: '确定',
                handler: function() {
                    customerDetailWin.hide();
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
            customerCreateWin.show(this);
        }
    }, {
        text: '修改',
        icon: '/foundation/images/skin/database_edit.png',
        handler: function() {
           updateCustomer();
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
                            url: '/foundation/customer/deleteJSON',
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
                customerDetailForm.getForm().load({
                    url:'/foundation/customer/detailJSON?id=' + id,
                    success:function(form, action) {
                    },
                    failure:function() {
                        Ext.foundation.msg('错误', '服务器出现错误，稍后再试!');
                    }
                });
                customerDetailWin.show();
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
        {header:'姓名',dataIndex:'name'} ,
        {header:'性别',dataIndex:'gender'} ,
        {header:'手机',dataIndex:'mobile'} ,
        {header:'身份证号',dataIndex:'identityCardNum'} ,
        {header:'等级',dataIndex:'level'} ,
        {header:'余额',dataIndex:'balance'} ,
        {header:'生日',dataIndex:'birthday'} ,
        {header:'创建时间',dataIndex:'dateCreated', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')} ,
        {header:'最近更新',dataIndex:'lastUpdated', type: 'date', renderer: Ext.util.Format.dateRenderer('Y-m-d')} 
    ]);

    var store = new Ext.data.Store({
        autoLoad:true,
        proxy: new Ext.data.HttpProxy({url:'/foundation/customer/listJSON'}),
        reader: new Ext.data.JsonReader({
            totalProperty:'total',
            root:'root'
        }, [
            {name:'id'  } ,
            {name:'name'  } ,
            {name:'gender'  } ,
            {name:'mobile'  } ,
            {name:'identityCardNum'  } ,
            {name:'level'  } ,
            {name:'balance'  } ,
            {name:'birthday'  } ,
            {name:'dateCreated' , type:'date', dateFormat:'c' } ,
            {name:'lastUpdated' , type:'date', dateFormat:'c' } 
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
        updateCustomer();
    });

    function updateCustomer()
    {
        var id = (grid.getSelectionModel().getSelected()).id;
        if (id == null) {
            Ext.foundation.msg('注意', "请选择要修改的记录");
        } else {
            customerUpdateForm.getForm().load({
                url:'/foundation/customer/detailJSON?id=' + id,
                success:function(form, action) {
                    customerUpdateWin.show();
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
        <div id="customerCreateWin"></div>
        <div id="customerUpdateWin"></div>
        <div id="customerDetailWin"></div>
    </body>
</html>
