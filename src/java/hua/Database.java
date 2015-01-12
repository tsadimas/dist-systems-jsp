/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hua;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author rg
 */
public class Database {
   
     public static Connection getConnection() {
          try  {
              Class.forName("com.mysql.jdbc.Driver");
              Connection con = DriverManager.getConnection
                      ("jdbc:mysql://83.212.105.20:3306/sakila",
                      "sakila","sakila");
              return con;
          }
          catch(Exception ex) {
              System.out.println("Database.getConnection() Error -->" + ex.getMessage());
              return null;
          }
      }
 
       public static void close(Connection con) {
          try  {
              con.close();
          }
          catch(Exception ex) {
          }
      }

}
