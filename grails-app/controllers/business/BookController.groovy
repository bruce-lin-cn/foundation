package business

class BookController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def afterInterceptor = { model ->
        println "tracing action uri:"+actionUri
        println "model:"+model
	}

    def index = {
        [:]
    }

    def tab = {
        [:]
    }

    def associationListJSON = {

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

            def associationList=[]
            lists.each{item ->
                associationList.add(new HashMap(id:item.id, book:item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
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
            def renderList=[]
            lists.each{item ->
                renderList.add(new HashMap(id: item.id,string1: item.string1,string2: item.string2,date1: item.date1,ingeger1: item.ingeger1,float1: item.float1,boolean1: item.boolean1,company: item.company.toString()))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {

        def bookInstance = Book.get(params.id)

        println("AJAX: Detailing "+bookInstance?.toString())

        if (bookInstance) {
            try {

                def map=new HashMap(id: bookInstance.id,string1: bookInstance.string1,string2: bookInstance.string2,date1: bookInstance.date1,ingeger1: bookInstance.ingeger1,float1: bookInstance.float1,boolean1: bookInstance.boolean1,company: bookInstance.company.toString())

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

        def book=new Book()

        book.string1=params.string1
        book.string2=params.string2
        book.date1=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.date1)
        book.ingeger1=params.ingeger1.toInteger()
        book.float1=params.float1.toFloat()
        book.boolean1=params.boolean1?true:false

        book.company=Company.get(params.company)

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
        book.boolean1=params.boolean1?true:false

        book.company=Company.get(params.company)

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
}