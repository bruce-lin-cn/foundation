package business

 class CustomerController {




    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def cgClass=grailsApplication.getArtefact("Domain","business.Customer")
    def cgConstraints=cgClass.getConstrainedProperties()
    def cgDomainProperties=[:]
    def initialized=false

    def index = {
        redirect(action: "extList", params: params)
    }

    def extList = {
        if(initialized==false)
        {
            init()
        }

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [customerInstanceList: Customer.list(params), customerInstanceTotal: Customer.count(),cgDomainProperties:cgDomainProperties]
    }

    def listJSON = {

        def total=Customer.count()
        def max=10
        def start=params.int('start')

        if(start==null)
        {
            start=0
        }
        def lists=[]
        def end=start+max-1
        if(end>=total)
        {
            end=total-1
        }

        lists=Customer.findAll()[start..end]

        def json=lists as grails.converters.JSON
        def output="{total:"+total+",root:"+json+ "}"

        render output
    }

    def createJSON = {
        println("AJAX: Creating "+params.toString())

        def customer=new Customer()

            
        customer.name=params.name
        customer.mobile=params.mobile
        customer.identityCardNum=params.identityCardNum
        customer.level=params.level
        customer.balance=params.balance
        //customer.id=null
        customer.save()

        render "{success:true,msg:'记录已创建'}";

    }

    def deleteJSON = {
        def customerInstance = Customer.get(params.id)

        println("AJAX: Deleting "+customerInstance?.toString())

        if (customerInstance) {
            try {
                def record= customerInstance.toString()
                customerInstance.delete()

                render "{success:true,msg:'"+record+"记录已删除'}";
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录删除失败'}";
            }
        }
        else {
            render "{success:false,msg:'记录不存在！'}";
        }
    }

    def list = {
        if(initialized==false)
        {
            init()
        }

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [customerInstanceList: Customer.list(params), customerInstanceTotal: Customer.count(),cgDomainProperties:cgDomainProperties]
    }


    def create = {
        if(initialized==false)
        {
            init()
        }

        def customerInstance = new Customer()
        customerInstance.properties = params
        return [customerInstance: customerInstance,cgDomainProperties:cgDomainProperties]
    }

    def save = {
        def customerInstance = new Customer(params)
        if (customerInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance.id])}"
            redirect(action: "show", id: customerInstance.id)
        }
        else {
            render(view: "create", model: [customerInstance: customerInstance,cgDomainProperties:cgDomainProperties])
        }
    }

    def show = {
        if(initialized==false)
        {
            init()
        }
        
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            [customerInstance: customerInstance,cgDomainProperties:cgDomainProperties]
        }
    }

    def edit = {
        if(initialized==false)
        {
            init()
        }
        
        def customerInstance = Customer.get(params.id)
        if (!customerInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [customerInstance: customerInstance,cgDomainProperties:cgDomainProperties]
        }
    }

    def update = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (customerInstance.version > version) {
                    
                    customerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'customer.label', default: 'Customer')] as Object[], "Another user has updated this Customer while you were editing")
                    render(view: "edit", model: [customerInstance: customerInstance,cgDomainProperties:cgDomainProperties])
                    return
                }
            }
            customerInstance.properties = params
            if (!customerInstance.hasErrors() && customerInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'customer.label', default: 'Customer'), customerInstance.id])}"
                redirect(action: "show", id: customerInstance.id,cgDomainProperties:cgDomainProperties)
            }
            else {
                render(view: "edit", model: [customerInstance: customerInstance,cgDomainProperties:cgDomainProperties])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def customerInstance = Customer.get(params.id)
        if (customerInstance) {
            try {
                customerInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), params.id])}"
            redirect(action: "list")
        }
    }



    def init(){
        cgDomainProperties.cgChinese=Customer.cgDomain.chinese

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
            }else{
                println ">>>>>> Unhandled propertiy:"+namePropertiy
            }
        }

        initialized=true
    }
}