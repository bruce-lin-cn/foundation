<html>
    <head>
        <title>浪漫晚餐</title>
        <g:extjs />
        <link rel="stylesheet" type="text/css" href="/foundation/ext/resources/css/ext-all.css" />
<script type="text/javascript" src="/foundation/ext/adapter/ext/ext-base.js" ></script>
<script type="text/javascript" src="/foundation/ext/ext-all.js" ></script>
<script type="text/javascript" src="/foundation/ext/ext-lang-zh_CN.js" ></script>
    </head>
    <g:onReadyBegin />
		var box= new Ext.BoxComponent({
            el:'box',
            style:'background-color:red;position:absolute;',
            pageX:100,
            pageY:200,
            width:300,
            height:150
        });

        box.render();
	<g:onReadyEnd />

    <script>
        Ext.onReady(function(){
            var panel = new Ext.Panel({
               el: 'panel',
               title: '刘亦菲',
               floating:true,
               shadow:true,
               draggable:true,
               collapsible:true,
               html:'刘亦菲邀请您参加NV晚宴',
               pageX:20,
               pageY:20,
               width:200,
               height:200
            });

            panel.render();

            var tabs= new Ext.TabPanel({
                renderTo: document.body,
                height: 600
            });

            tabs.add({
                title:'选择美女',
                html:'刘亦菲，蔡妍'
            });

            tabs.add(panel);
        });

    </script>
    <body>
    <div id="box"></div>
    <div id="panel"></div>
    </body>
</html>
