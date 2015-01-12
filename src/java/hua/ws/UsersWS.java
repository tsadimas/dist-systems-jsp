/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hua.ws;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import hua.UserManager;
import hua.User;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author rg
 */
@WebService(serviceName = "UsersWS")
public class UsersWS {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "hello")
    public String hello(@WebParam(name = "name") String txt) {
        return "Hello " + txt + " !";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "showUsers")
    public List<User> showUsers() {
        //TODO write your implementation code here:
        List<User> lu=new ArrayList<User>();
        UserManager um=new UserManager();
        lu=um.getAllUsers();
        return lu;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "getUser")
    public User getUser(@WebParam(name = "name") String name) {
        //TODO write your implementation code here:
        UserManager um=new UserManager();
        User u=um.getUserById(name);
        return u;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "createUser")
    public Boolean createUser(@WebParam(name = "uname") String uname, @WebParam(name = "email") String email, @WebParam(name = "password") String password) {
        //TODO write your implementation code here:
        UserManager um=new UserManager();
        User u=new User();
        u.setUname(uname);
        u.setEmail(email);
        u.setPassword(password);
        u.setRegisteredon(new Date());
        um.addUser(u);
        return true;
    }
}
