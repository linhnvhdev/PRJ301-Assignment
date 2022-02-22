/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dal.AccountDBContext;
import Model.Account;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Linhnvhdev
 */
public abstract class BaseAuthorController extends HttpServlet {
    public boolean isAuthenticated(HttpServletRequest request){
        Account acc = (Account) request.getSession().getAttribute("account");
        if(acc == null) return false;
        else{
            String url = request.getServletPath();
            AccountDBContext accDB = new AccountDBContext();
            int permission = accDB.getPermission(acc.getUsername(), url);
            return permission > 0;
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(isAuthenticated(request)){
            processGet(request,response);
        }
        else{
            response.getWriter().print("Access Denied");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(isAuthenticated(request)){
            processPost(request,response);
        }
        else{
            response.getWriter().print("Access Denied");
        }
        
    }
    
    protected abstract void processGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException;
            
    protected abstract void processPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;     
}
