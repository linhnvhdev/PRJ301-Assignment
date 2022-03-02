/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dal;

import Model.Classes;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Linhnvhdev
 */
public class ClassDBContext extends DBContext {
    
    public ArrayList<Classes> getClasses(){
        ArrayList<Classes> classes = new ArrayList<>();
        try {
            String sql="SELECT Id,Name\n" +
                    "FROM Class";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Classes c = new Classes();
                c.setId(rs.getInt("Id"));
                c.setName(rs.getString("Name"));
                classes.add(c);
            }
            return classes;
        } catch (SQLException ex) {
            Logger.getLogger(ClassDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return classes;
    }
    
    public Classes getClasses(int cid){
        try {
            String sql="SELECT Id,Name\n" +
                    "FROM Class\n" +
                    "WHERE Id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cid);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                Classes c = new Classes();
                c.setId(rs.getInt("Id"));
                c.setName(rs.getString("Name"));
                return c;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
