package business

class EmployeeController {

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

        def total=Employee.count()

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


            lists = Employee.findAll()[start..end]

            def associationList=[]
            lists.each{item ->
                associationList.add(new HashMap(id:item.id, employee:item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def listJSON = {

        def total=Employee.count()

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

            lists = Employee.findAll()[start..end]
            def renderList=[]
            lists.each{item ->
                renderList.add(new HashMap(id: item.id,name: item.name,gender: item.gender,birthday: item.birthday,book: item.book.toString(),company: item.company.toString()))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {

        def employeeInstance = Employee.get(params.id)

        println("AJAX: Detailing "+employeeInstance?.toString())

        if (employeeInstance) {
            try {

                def map=new HashMap(id: employeeInstance.id,name: employeeInstance.name,gender: employeeInstance.gender,birthday: employeeInstance.birthday,book: employeeInstance.book.toString(),company: employeeInstance.company.toString())

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

        def employee=new Employee()

        employee.name=params.name
        employee.gender=params.gender
        employee.birthday=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.birthday)

        employee.book=Book.get(params.book)

        employee.company=Company.get(params.company)

        employee.save()

        render "{success:true,msg:'记录已创建'}";

    }

    //TODO: 版本判断
    def updateJSON = {
        println("AJAX: Updating "+params.toString())
        def employeeInstance = Employee.get(params.id)
        def employee=Employee.get(params.id)

        employee.name=params.name
        employee.gender=params.gender
        employee.birthday=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.birthday)

        employee.book=Book.get(params.book)

        employee.company=Company.get(params.company)

        employee.save()

        render "{success:true,msg:'记录已更新'}";

    }

    def deleteJSON = {
        try{
            def idList=[]
            idList=params.id

            for(int i=0;i<idList.size();i++)
            {
                def tmp=Employee.get(idList[i])

                tmp?.delete()
            }

            render "{success:true,msg:'"+idList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录删除失败'}";
        }
    }
}