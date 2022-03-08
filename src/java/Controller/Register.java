/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dal.AccountDBContext;
import Dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Linhnvhdev
 */
public class Register extends HttpServlet {
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("View/register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_role = request.getParameter("role");
        String raw_username = request.getParameter("username");
        String raw_password = request.getParameter("password");
        String raw_retypePassword = request.getParameter("retypePassword");
        String raw_name = request.getParameter("name");
        String raw_gender = request.getParameter("gender");
        String raw_phoneNumber = request.getParameter("phoneNumber");
        String raw_gmail = request.getParameter("gmail");
        // Validate data
        String role = raw_role;
        String username = raw_username;
        String password = raw_password;
        String retypePassword = raw_retypePassword;
        String name = raw_name;
        boolean gender = Boolean.parseBoolean(raw_gender);
        String phoneNumber = raw_phoneNumber;
        String gmail = raw_gmail;
        //
        AccountDBContext accDB = new AccountDBContext();
        UserDBContext userDB = new UserDBContext();
        
        if(accDB.isAccountExist(username)){
            response.getWriter().print("Tài khoản đã tồn tại");
            request.getRequestDispatcher("View/register.jsp").include(request, response);
        }
        else{
            int userId = userDB.insertUser(name, gender, phoneNumber, gmail, role);
            accDB.createAccount(username,password,userId);
            response.getWriter().print("Đăng kí thành công");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}