import business.*
import groovy.text.SimpleTemplateEngine
import org.codehaus.groovy.grails.commons.ApplicationHolder as AH

class BootStrap {

    def grailsApplication

    def init = { servletContext ->
        new Company(name: "谷歌中国").save()
        new Company(name: "微软中国").save()

        new Department(name: "财务部").save()
        new Department(name: "市场部").save()

        // navigation:[group:"业务管理",weight:1
        grailsApplication.getArtefacts("Domain")*.clazz.each{domain ->
            println domain.name
            println domain.cgDomain.navigation
        }
        //result= generateFile "$templateDir/_index.gsp", "$appDir/views/index.gsp"

        //println result
        //生成首页
        //def template= new File("./src/templates/tmp.gsp").text
//        def navigations =[:]
//        grailsApplication.getArtefacts("Domain")*.clazz.each{domain ->
//            if(domain.cgDomain.navigation!=null)
//            {
//                if(navigations[domain.cgDomain.navigation.group]==null)
//                {
//                    navigations[domain.cgDomain.navigation.group]=[]
//                }
//                navigations[domain.cgDomain.navigation.group].add(new HashMap(name:domain.cgDomain.chinese+"管理", weight:domain.cgDomain.navigation.weight))
//            }
//        }

        //def ctx = AH.application.mainContext
        //println ctx

//        println navigations
//
//        def engine = new SimpleTemplateEngine()
//
//        println engine.createTemplate(template).make(new HashMap(navigations:navigations)).toString()

    }
    def destroy = {
    }
}


//def text = 'Dear "$firstname $lastname",\nSo nice to meet you in <% print city %>.\nSee you in ${month},\n${signed}'

//def binding = ["firstname":"Sam", "lastname":"Pullara", "city":"San Francisco", "month":"December", "signed":"Groovy-Dev"]

//def engine = new SimpleTemplateEngine()
//template = engine.createTemplate(text).make(binding)

//def result = 'Dear "Sam Pullara",\nSo nice to meet you in San Francisco.\nSee you in December,\nGroovy-Dev'
