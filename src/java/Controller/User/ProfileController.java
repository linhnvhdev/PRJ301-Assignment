/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller.User;

import Dal.StudentDBContext;
import Dal.TeacherDBContext;
import Dal.UserDBContext;
import Model.Account;
import Model.Student;
import Model.Teacher;
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
public class ProfileController extends HttpServlet {

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
        Account account = (Account) request.getSession().getAttribute("account");
        int userId = account.getUser().getId();
        UserDBContext userDB = new UserDBContext();
        account.setUser(userDB.getUser(userId));
        if(account.getUser().getRole() == 3){
            TeacherDBContext teacherDB = new TeacherDBContext();
            Teacher teacher = teacherDB.getTeacherByUserId(userId);
            request.setAttribute("teacher", teacher);
        }
        else if(account.getUser().getRole() == 4){
            StudentDBContext studentDB = new StudentDBContext();
            Student student = studentDB.getStudentByUserId(userId);
            request.setAttribute("student", student);
        }
        request.getRequestDispatcher("View/User/profile.jsp").forward(request, response);
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
