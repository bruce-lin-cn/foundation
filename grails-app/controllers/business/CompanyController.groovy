package business

class CompanyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def cgClass=grailsApplication.getArtefact("Domain","business.Company")
    def cgConstraints=cgClass.getConstrainedProperties()
    def cgDomainProperties=[:]
    def initialized=false

    def afterInterceptor = { model ->
		model.cgDomainProperties=cgDomainProperties
	}

    def index = {
        if(initialized==false)
        {
            init()
        }

        []
    }

    def associationListJSON = {

        def total=Company.count()

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


            lists = Company.findAll()[start..end]

            def associationList=[]
            lists.each{item ->
                associationList.add(new HashMap(id:item.id, company:item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def listJSON = {

        def total=Company.count()

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

            lists = Company.findAll()[start..end]
            def renderList=[]
            lists.each{item ->
                renderList.add(new HashMap(id: item.id,name: item.name))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {

        def companyInstance = Company.get(params.id)

        println("AJAX: Detailing "+companyInstance?.toString())

        if (companyInstance) {
            try {

                def map=new HashMap(id: companyInstance.id,name: companyInstance.name)

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

        def company=new Company()

        company.name=params.name

        company.save()

        render "{success:true,msg:'记录已创建'}";

    }

    //TODO: 版本判断
    def updateJSON = {
        println("AJAX: Updating "+params.toString())
        def companyInstance = Company.get(params.id)
        def company=Company.get(params.id)

        company.name=params.name

        company.save()

        render "{success:true,msg:'记录已更新'}";

    }

    def deleteJSON = {
        try{
            def idList=[]
            idList=params.id

            for(int i=0;i<idList.size();i++)
            {
                def tmp=Company.get(idList[i])

                tmp?.delete()
            }

            render "{success:true,msg:'"+idList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录删除失败'}";
        }
    }

    def init(){
        cgDomainProperties.cgChinese=Company.cgDomain.chinese

        cgClass.getProperties().each{
            def namePropertiy=it.getName()

            if(namePropertiy == 'id')
            {
                cgDomainProperties[namePropertiy]=[chinese:'编号']
            }else if(namePropertiy=='version')
	    {

	    }else if(namePropertiy == 'dateCreated')
            {
                cgDomainProperties[namePropertiy]=[chinese:'创建']
            }else if(namePropertiy == 'lastUpdated')
            {
                cgDomainProperties[namePropertiy]=[chinese:'更新']
            }else if(it.isPersistent()==true && cgConstraints[namePropertiy]!=null && namePropertiy!='version'){
                cgDomainProperties[namePropertiy]=[chinese:cgConstraints[namePropertiy].attributes.chinese?:namePropertiy]
                if(cgConstraints[namePropertiy].attributes.format != null) {
                    cgDomainProperties[namePropertiy].format = cgConstraints[namePropertiy].attributes.format
                }
            }else{
                println ">>>>>> Unhandled propertiy:"+namePropertiy
            }
        }

        initialized=true
    }
}