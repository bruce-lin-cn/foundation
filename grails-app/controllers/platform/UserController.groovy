package platform

 class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def cgClass=grailsApplication.getArtefact("Domain","platform.User")
    def cgConstraints=cgClass.getConstrainedProperties()
    def cgDomainProperties=[:]
    def initialized=false

    def index = {
        redirect(action: "list", params: params)
    }

    def listJSON = {

        def total=User.count()
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

        lists=User.findAll()[start..end]

        def json=lists as grails.converters.JSON
        def output="{total:"+total+",root:"+json+ "}"

        render output
    }

    def list = {
        if(initialized==false)
        {
            init()
        }

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count(),cgDomainProperties:cgDomainProperties]
    }
    def extList = {
        if(initialized==false)
        {
            init()
        }

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count(),cgDomainProperties:cgDomainProperties]
    }

    def create = {
        if(initialized==false)
        {
            init()
        }

        def userInstance = new User()
        userInstance.properties = params
        return [userInstance: userInstance,cgDomainProperties:cgDomainProperties]
    }

    def save = {
        def userInstance = new User(params)
        if (userInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
            redirect(action: "show", id: userInstance.id)
        }
        else {
            render(view: "create", model: [userInstance: userInstance,cgDomainProperties:cgDomainProperties])
        }
    }

    def show = {
        if(initialized==false)
        {
            init()
        }
        
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userInstance: userInstance,cgDomainProperties:cgDomainProperties]
        }
    }

    def edit = {
        if(initialized==false)
        {
            init()
        }
        
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userInstance: userInstance,cgDomainProperties:cgDomainProperties]
        }
    }

    def update = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userInstance.version > version) {
                    
                    userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
                    render(view: "edit", model: [userInstance: userInstance,cgDomainProperties:cgDomainProperties])
                    return
                }
            }
            userInstance.properties = params
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])}"
                redirect(action: "show", id: userInstance.id,cgDomainProperties:cgDomainProperties)
            }
            else {
                render(view: "edit", model: [userInstance: userInstance,cgDomainProperties:cgDomainProperties])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            try {
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    def init(){
        cgDomainProperties.cgChinese=User.cgDomain.chinese

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