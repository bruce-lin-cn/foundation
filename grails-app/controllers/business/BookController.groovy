package business

class BookController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def cgClass=grailsApplication.getArtefact("Domain","business.Book")
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
        [bookInstanceList: Book.list(params), bookInstanceTotal: Book.count(),cgDomainProperties:cgDomainProperties]
    }

    def listJSON = {

        def total=Book.count()

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

            lists = Book.findAll()[start..end]

            def json = lists as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {

        def bookInstance = Book.get(params.id)

        println("AJAX: Detailing "+bookInstance?.toString())

        if (bookInstance) {
            try {
                def json=bookInstance as grails.converters.JSON

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

        def book=new Book()

        book.string1=params.string1
        book.string2=params.string2
        book.date1=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.date1)
        book.ingeger1=params.ingeger1.toInteger()
        book.float1=params.float1.toFloat()
        book.boolean1=params.boolean1


        book.save()

        render "{success:true,msg:'记录已创建'}";

    }

    //TODO: 版本判断
    def updateJSON = {
        println("AJAX: Updating "+params.toString())
        def bookInstance = Book.get(params.id)
        def book=Book.get(params.id)

        book.string1=params.string1
        book.string2=params.string2
        book.date1=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.date1)
        book.ingeger1=params.ingeger1.toInteger()
        book.float1=params.float1.toFloat()
        book.boolean1=params.boolean1

        book.save()

        render "{success:true,msg:'记录已更新'}";

    }

    def deleteJSON = {
        try{
            def idList=[]
            idList=params.id

            for(int i=0;i<idList.size();i++)
            {
                def tmp=Book.get(idList[i])

                tmp?.delete()
            }

            render "{success:true,msg:'"+idList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录删除失败'}";
        }
    }

    def list = {
        if(initialized==false)
        {
            init()
        }

        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [bookInstanceList: Book.list(params), bookInstanceTotal: Book.count(),cgDomainProperties:cgDomainProperties]
    }


    def create = {
        if(initialized==false)
        {
            init()
        }

        def bookInstance = new Book()
        bookInstance.properties = params
        return [bookInstance: bookInstance,cgDomainProperties:cgDomainProperties]
    }

    def save = {
        def bookInstance = new Book(params)
        if (bookInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])}"
            redirect(action: "show", id: bookInstance.id)
        }
        else {
            render(view: "create", model: [bookInstance: bookInstance,cgDomainProperties:cgDomainProperties])
        }
    }

    def show = {
        if(initialized==false)
        {
            init()
        }

        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])}"
            redirect(action: "list")
        }
        else {
            [bookInstance: bookInstance,cgDomainProperties:cgDomainProperties]
        }
    }

    def edit = {
        if(initialized==false)
        {
            init()
        }

        def bookInstance = Book.get(params.id)
        if (!bookInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [bookInstance: bookInstance,cgDomainProperties:cgDomainProperties]
        }
    }

    def update = {
        def bookInstance = Book.get(params.id)
        if (bookInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (bookInstance.version > version) {
                    
                    bookInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'book.label', default: 'Book')] as Object[], "Another user has updated this Book while you were editing")
                    render(view: "edit", model: [bookInstance: bookInstance,cgDomainProperties:cgDomainProperties])
                    return
                }
            }
            bookInstance.properties = params
            if (!bookInstance.hasErrors() && bookInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'book.label', default: 'Book'), bookInstance.id])}"
                redirect(action: "show", id: bookInstance.id,cgDomainProperties:cgDomainProperties)
            }
            else {
                render(view: "edit", model: [bookInstance: bookInstance,cgDomainProperties:cgDomainProperties])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def bookInstance = Book.get(params.id)
        if (bookInstance) {
            try {
                bookInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'book.label', default: 'Book'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'book.label', default: 'Book'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'book.label', default: 'Book'), params.id])}"
            redirect(action: "list")
        }
    }



    def init(){
        cgDomainProperties.cgChinese=Book.cgDomain.chinese

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