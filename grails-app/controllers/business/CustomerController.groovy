package business

class CustomerController {

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

        def total=Customer.count()

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


            lists = Customer.findAll()[start..end]

            def associationList=[]
            lists.each{item ->
                associationList.add(new HashMap(id:item.id, customer:item.toString()))
            }

            def json = associationList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def listJSON = {

        def total=Customer.count()

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

            lists = Customer.findAll()[start..end]
            def renderList=[]
            lists.each{item ->
                renderList.add(new HashMap(id: item.id,name: item.name,gender: item.gender,mobile: item.mobile,identityCardNum: item.identityCardNum,level: item.level,balance: item.balance,birthday: item.birthday,dateCreated: item.dateCreated,lastUpdated: item.lastUpdated))
            }
            def json = renderList as grails.converters.JSON
            def output = "{total:" + total + ",root:" + json + "}"

            render output
        }
    }

    def detailJSON = {

        def customerInstance = Customer.get(params.id)

        println("AJAX: Detailing "+customerInstance?.toString())

        if (customerInstance) {
            try {

                def map=new HashMap(id: customerInstance.id,name: customerInstance.name,gender: customerInstance.gender,mobile: customerInstance.mobile,identityCardNum: customerInstance.identityCardNum,level: customerInstance.level,balance: customerInstance.balance,birthday: customerInstance.birthday,dateCreated: customerInstance.dateCreated,lastUpdated: customerInstance.lastUpdated)

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

        def customer=new Customer()

        customer.name=params.name
        customer.gender=params.gender
        customer.mobile=params.mobile
        customer.identityCardNum=params.identityCardNum
        customer.level=params.level
        customer.balance=params.balance
        customer.birthday=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.birthday)

        customer.save()

        render "{success:true,msg:'记录已创建'}";

    }

    //TODO: 版本判断
    def updateJSON = {
        println("AJAX: Updating "+params.toString())
        def customerInstance = Customer.get(params.id)
        def customer=Customer.get(params.id)

        customer.name=params.name
        customer.gender=params.gender
        customer.mobile=params.mobile
        customer.identityCardNum=params.identityCardNum
        customer.level=params.level
        customer.balance=params.balance
        customer.birthday=(new java.text.SimpleDateFormat("yyyy-MM-dd")).parse(params.birthday)

        customer.save()

        render "{success:true,msg:'记录已更新'}";

    }

    def deleteJSON = {
        try{
            def idList=[]
            idList=params.id

            for(int i=0;i<idList.size();i++)
            {
                def tmp=Customer.get(idList[i])

                tmp?.delete()
            }

            render "{success:true,msg:'"+idList.size()+"条记录已删除'}";
        }catch (org.springframework.dao.DataIntegrityViolationException e) {
                render "{success:false,msg:'记录删除失败'}";
        }
    }
}