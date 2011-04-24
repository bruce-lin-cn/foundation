package business

class DepartmentEmployeeController {

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

        def total=DepartmentEmployee.count()

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


            lists = DepartmentEmployee.findAll()[start..end]

            def associationList=[]
            lists.each{item ->
                associationList.add(new HashMap(id:item.id, departmentEmployee:item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def listJSON = {

        def total=DepartmentEmployee.count()

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

            lists = DepartmentEmployee.findAll()[start..end]
            def renderList=[]
            lists.each{item ->
                renderList.add(new HashMap(id: item.id,department: item.department.toString(),employee: item.employee.toString()))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {

        def departmentEmployeeInstance = DepartmentEmployee.get(params.id)

        println("AJAX: Detailing "+departmentEmployeeInstance?.toString())

        if (departmentEmployeeInstance) {
            try {

                def map=new HashMap(id: departmentEmployeeInstance.id,department: departmentEmployeeInstance.department.toString(),employee: departmentEmployeeInstance.employee.toString())

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

        def departmentEmployee=new DepartmentEmployee()

        departmentEmployee.department=Department.get(params.department.toLong())
        departmentEmployee.employee=Employee.get(params.employee.toLong())

        departmentEmployee.save()

        render "{success:true,msg:'记录已创建'}";

    }

    //TODO: 版本判断
    def updateJSON = {
        println("AJAX: Updating "+params.toString())
        def departmentEmployeeInstance = DepartmentEmployee.get(params.id)
        def departmentEmployee=DepartmentEmployee.get(params.id)

        departmentEmployee.department=Department.get(params.department.toLong())
        departmentEmployee.employee=Employee.get(params.employee.toLong())

        departmentEmployee.save()

        render "{success:true,msg:'记录已更新'}";

    }

    def deleteJSON = {
        try{
            def idList=[]
            idList=params.id

            for(int i=0;i<idList.size();i++)
            {
                def tmp=DepartmentEmployee.get(idList[i])

                tmp?.delete()
            }

            render "{success:true,msg:'"+idList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录删除失败'}";
        }
    }
}