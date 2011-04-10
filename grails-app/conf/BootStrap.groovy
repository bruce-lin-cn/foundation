import business.*

class BootStrap {

    def init = { servletContext ->
        new Company(name: "谷歌中国").save()
        new Company(name: "微软中国").save()

        new Employee(name: "林禹.福州")

        println servletContext.class
        //grailsApplication.getArtefacts("Domain")*.clazz.each{domain ->
        //    println domain
        //}

    }
    def destroy = {
    }
}
