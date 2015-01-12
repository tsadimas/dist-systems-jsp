/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hua;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.validation.constraints.*;

/**
 *
 * @author rg
 */
public class User {
    @NotNull 
    private String uname;
    private String password;
    private String email;
    private Date registeredon;

    /**
     * @return the uname
     */
    public String getUname() {
        return uname;
    }

    /**
     * @param uname the uname to set
     */
    public void setUname(String uname) {
        this.uname = uname;
    }
    
    

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the registeredon
     */
    public Date getRegisteredon() {
        return registeredon;
    }

    /**
     * @param registeredon the registeredon to set
     */
    public void setRegisteredon(Date registeredon) {
        
        this.registeredon = registeredon;
    }

    public void setregdate(String regdate){
        
            try {
                Date reg = new SimpleDateFormat("yyyy/MM/dd").parse(regdate);
                System.out.println("regdate" + reg);
                this.registeredon=reg;
            } catch (ParseException e) {
                e.printStackTrace();
            }

    }
}
