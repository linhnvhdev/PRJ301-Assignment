/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Linhnvhdev
 */
public class UserDBContext extends DBContext {
    public int getLastInserted(){
        try {
            String sql="SELECT MAX(Id) maxId FROM [User]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if(rs.next()) return rs.getInt("maxId");
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public int insertUser(String name, boolean gender, String phoneNumber,String Gmail, String role){
        try {
            String sql="INSERT INTO [PRJ301-Assignment].[dbo].[User]\n" +
                    "           ([Name]\n" +
                    "           ,[Sex]\n" +
                    "           ,[PhoneNumber]\n" +
                    "           ,[Gmail]\n" +
                    "           ,[RoleId])\n" +
                    "     VALUES\n" +
                    "           (?\n" +
                    "           ,?\n" +
                    "           ,?\n" +
                    "           ,?\n" +
                    "           ,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            stm.setBoolean(2, gender);
            stm.setString(3, phoneNumber);
            stm.setString(4, Gmail);
            stm.setInt(5, getRoleId(role));
            stm.executeUpdate();
            return getLastInserted();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    private int getRoleId(String role) {
        int roleId = 0;
        switch(role){
            case "admin":
                roleId = 1;
                break;
            case "manager":
                roleId = 2;
                break;
            case "teacher":
                roleId = 3;
                break;
            case "student":
                roleId = 4;
                break;
        }
        return roleId;
    }

    public void update(int userId, String name, boolean gender, String phoneNumber, String gmail, String role) {
        try {
            String sql="UPDATE [PRJ301-Assignment].[dbo].[User]\n" +
            "   SET [Name] = ?\n" +
            "      ,[Sex] = ?\n" +
            "      ,[PhoneNumber] = ? \n" +
            "      ,[Gmail] = ?\n" +
            "      ,[RoleId] = ?\n" +
            "   WHERE Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            stm.setBoolean(2, gender);
            stm.setString(3, phoneNumber);
            stm.setString(4, gmail);
            stm.setInt(5, getRoleId(role));
            stm.setInt(6, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }       
    }

    public void delete(int userId) {
        try {
            String sql="DELETE FROM [PRJ301-Assignment].[dbo].[User]\n" +
            "      WHERE Id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }           
    }

    public ArrayList<Integer> getUser(String name, String gender, String phoneNumber, String gmail,String role) {
        ArrayList<Integer> userIds = new ArrayList<>();
        try {
            String sql = "SELECT [Id]\n" +
            "  FROM [PRJ301-Assignment].[dbo].[User]\n" +
            "  WHERE Id>0";
            if(!name.equals("none"))
                sql += " AND [Name] = ?";
            if(!gender.equals("none"))
                sql += " AND [Sex] = ?";
            if(!phoneNumber.equals("none"))
                sql += " AND [phoneNumber] = ?";
            if(!gmail.equals("none"))
                sql += " AND [Gmail] = ?";
            sql += " AND [RoleId] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            int i = 0;
            if(!name.equals("none"))
                stm.setString(++i, name);
            if(!gender.equals("none"))
                stm.setBoolean(++i, Boolean.parseBoolean(gender));
            if(!phoneNumber.equals("none"))
                stm.setString(++i, phoneNumber);
            if(!gmail.equals("none"))
                stm.setString(++i, gmail);
            stm.setInt(++i, getRoleId(role));
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                userIds.add(rs.getInt("Id"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userIds;
    }
}
