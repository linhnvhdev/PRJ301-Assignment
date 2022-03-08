/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dal;

import Model.Account;
import Model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Linhnvhdev
 */
public class AccountDBContext extends DBContext {
    public boolean isAccountExist(String username){
        try {
            String sql ="SELECT COUNT(*) AS Total\n" +
            "FROM Account\n" +
            "WHERE [Username] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                return (rs.getInt("Total") > 0);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public Account getAccount(String username, String password){
        try {
            String sql ="SELECT [Username],[Password],[UserId]\n" +
            "FROM Account\n" +
            "WHERE [Username] = ? AND [Password] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                Account acc = new Account();
                acc.setUsername(rs.getString("Username"));
                acc.setPassword(rs.getString("Password"));
                UserDBContext userDB = new UserDBContext();
                User user = userDB.getUser(rs.getInt("UserId"));
                acc.setUser(user);
                return acc;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int getPermission(String username,String url){
        try {
            String sql ="SELECT COUNT(*) AS Total\n" +
            "FROM [Account] a INNER JOIN [User] u ON a.UserId = u.Id\n" +
            "               INNER JOIN [Role] r ON u.RoleId = r.Id\n" +
            "               INNER JOIN [Role_Function] rf ON r.Id = rf.RoleId\n" +
            "               INNER JOIN [Function] f ON rf.FunctionId = f.Id\n" +
            "WHERE a.Username = ? AND URL = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, url);
            ResultSet rs = stm.executeQuery();
            if(rs.next()){
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public void createAccount(String username, String password, int userId) {
        try {
            String sql="INSERT INTO [PRJ301-Assignment].[dbo].[Account]\n" +
            "           ([Username]\n" +
            "           ,[Password]\n" +
            "           ,[UserId])\n" +
            "     VALUES\n" +
            "           (?\n" +
            "           ,?\n" +
            "           ,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            stm.setInt(3, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }    
    }
    
    public void deleteAccount(int userId){
        try {
            String sql="DELETE FROM [PRJ301-Assignment].[dbo].[Account]\n" +
                    "      WHERE UserId = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changePassword(String username, String passwordNew) {
        try {
            String sql = "UPDATE [PRJ301-Assignment].[dbo].[Account]\n" +
                    "   SET [Password] = ?\n" +
                    " WHERE Username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, passwordNew);
            stm.setString(2, username);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
