import business.*

class BootStrap {

    def init = { servletContext ->
        new Company(name: "谷歌中国").save()
        new Company(name: "微软中国").save()

        //grailsApplication.getArtefacts("Domain")*.clazz.each{domain ->
        //    println domain
        //}

    }
    def destroy = {
    }
}
