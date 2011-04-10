<%=packageName ? "package ${packageName}\n\n" : ''%>class ${className}Controller {<% import grails.persistence.Event %><% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %><% boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate') %>
<%
    cgConstraints=domainClass.getConstrainedProperties()
    cgDomainProperties=[:]
    boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')

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

    def ViewToModelConverter(p) {
        if (p.type == Date.class) {
            out << "        ${domainClass.propertyName}.${p.name}=(new java.text.SimpleDateFormat(\"yyyy-MM-dd\")).parse(params.${p.name})"
            println ""
        } else if (p.type == int) {
            out << "        ${domainClass.propertyName}.${p.name}=params.${p.name}.toInteger()"
            println ""
        } else if (p.type == float) {
            out << "        ${domainClass.propertyName}.${p.name}=params.${p.name}.toFloat()"
            println ""
        } else if (p.type == boolean) {
            out << "        ${domainClass.propertyName}.${p.name}=params.${p.name}?true:false"
            println ""
        } else if (p.type == String.class) {
            out << "        ${domainClass.propertyName}.${p.name}=params.${p.name}"
            println ""
        } else if (p.isAssociation() && p.oneToOne) {
            println ""
            out << "        ${domainClass.propertyName}.${p.name}=${p.name.capitalize()}.get(params.${p.name})"
            println ""
        } else {
                out << "        ${p}"
                out << "class: ${domainClass}"
        }
    }

%>
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
        [:]
    }

    def associationListJSON = {

        def total=${className}.count()

        if(total==0)
        {
            render "{total:"+total+",root:[]}"
        } else {
            def max = 10
            def start = params.int('start')

            if (start == null) {
                start = 0
            }
            def lists = []
            def end = start + max - 1
            if (end >= total) {
                end = total - 1
            }


            lists = ${className}.findAll()[start..end]

            def associationList=[]
            lists.each{item ->
                associationList.add(new HashMap(id:item.id, ${domainClass.propertyName}:item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def listJSON = {

        def total=${className}.count()

        if(total==0)
        {
            render "{total:"+total+",root:[]}"
        } else {
            def max = 10
            def start = params.int('start')

            if (start == null) {
                start = 0
            }
            def lists = []
            def end = start + max - 1
            if (end >= total) {
                end = total - 1
            }

            lists = ${className}.findAll()[start..end]
            def renderList=[]
            lists.each{item ->
                renderList.add(new HashMap(<%  excludedProps = Event.allEvents.toList() << 'version'
                    allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                    props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
                    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                    props.eachWithIndex { p, i ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
                                    if (hasHibernate) {
                                        cp = domainClass.constrainedProperties[p.name]
                                        display = (cp ? cp.display : true)
                                    }
                                    if (display) {
                                        out << "${p.name}:"
                                        if(p.isAssociation())
                                        {
                                            out << " item.${p.name}.toString()"
                                        }else{
                                            out << " item.${p.name}"
                                        }
                                        if(i<props.size()-1)
                                        {
                                            out << ","
                                        }
                                    }
                                }
                    } %>))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {

        def ${propertyName} = ${className}.get(params.id)

        println("AJAX: Detailing "+${propertyName}?.toString())

        if (${propertyName}) {
            try {

                def map=new HashMap(<%  excludedProps = Event.allEvents.toList() << 'version'
                    allowedNames = domainClass.persistentProperties*.name << 'id' << 'dateCreated' << 'lastUpdated'
                    props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && !Collection.isAssignableFrom(it.type) }
                    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                    props.eachWithIndex { p, i ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
                                    if (hasHibernate) {
                                        cp = domainClass.constrainedProperties[p.name]
                                        display = (cp ? cp.display : true)
                                    }
                                    if (display) {
                                        out << "${p.name}:"
                                        if(p.isAssociation())
                                        {
                                            out << " ${propertyName}.${p.name}.toString()"
                                        }else{
                                            out << " ${propertyName}.${p.name}"
                                        }
                                        if(i<props.size()-1)
                                        {
                                            out << ","
                                        }
                                    }
                                }
                    } %>)

                def json=map as grails.converters.JSON

                render "{success:true, data:"+json+"}";
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录不存在！'}";
            }
        }
        else {
            render "{success:false,msg:'记录不存在！'}";
        }
    }

    def createJSON = {
        println("AJAX: Creating "+params.toString())

        def ${domainClass.propertyName}=new ${className}()

<%  excludedProps = Event.allEvents.toList() << 'version'<< 'dateCreated' << 'lastUpdated'
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
                                        ViewToModelConverter(p)

                                    }
                                }
                    }
%>
        ${domainClass.propertyName}.save()

        render "{success:true,msg:'记录已创建'}";

    }

    //TODO: 版本判断
    def updateJSON = {
        println("AJAX: Updating "+params.toString())
        def ${propertyName} = ${className}.get(params.id)
        def ${domainClass.propertyName}=${className}.get(params.id)

<%  excludedProps = Event.allEvents.toList() << 'version'<< 'dateCreated' << 'lastUpdated'
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
                                        ViewToModelConverter(p)
                                    }
                                }
                    }
%>
        ${domainClass.propertyName}.save()

        render "{success:true,msg:'记录已更新'}";

    }

    def deleteJSON = {
        try{
            def idList=[]
            idList=params.id

            for(int i=0;i<idList.size();i++)
            {
                def tmp=${className}.get(idList[i])

                tmp?.delete()
            }

            render "{success:true,msg:'"+idList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录删除失败'}";
        }
    }
}