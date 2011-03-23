import platform.User
import business.Customer

class BootStrap {

    def init = { servletContext ->
        new User(name:"林禹",mobile:"18906057051",identityCardNum: "350105197901182331").save();
        new User(name:"周良",mobile:"18906057052",identityCardNum: "350105197901182332").save();
        new User(name:"孟丽珠",mobile:"18906057053",identityCardNum: "350105197901182333").save();

        for( int i=0; i< 30; i++)
        {
            new User(name:"姓名"+i,mobile:"189060570"+i,identityCardNum: "35010519790118000"+i).save();
        }

        String name
    String mobile
    String identityCardNum
    String level
    String balance

        for( int i=0;i<100;i++)
        {
            new Customer(name:"姓名"+i,mobile:"189060570"+i,identityCardNum: "35010519790118000"+i,level:"高级",balance:"100").save()
        }
    }
    def destroy = {
    }
}
