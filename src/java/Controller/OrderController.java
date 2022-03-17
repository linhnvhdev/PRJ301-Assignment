/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dal.OrderDBContext;
import Dal.StudentDBContext;
import Dal.TeacherDBContext;
import Model.Account;
import Model.Order;
import Model.Student;
import Model.Teacher;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Hashtable;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Linhnvhdev
 */
public class OrderController extends HttpServlet {

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
        // Get data
        Account account = (Account) request.getSession().getAttribute("account");
        User user = account.getUser();
        String raw_month = request.getParameter("month");
        String raw_year = request.getParameter("year");
        String raw_search = request.getParameter("search");
        LocalDate curDate = LocalDate.now();
        int month = curDate.getMonthValue();
        int year = curDate.getYear();
        int day = curDate.getDayOfMonth();
        boolean search = false;
        if(raw_month != null) month = Integer.parseInt(raw_month);
        if(raw_year != null) year = Integer.parseInt(raw_year);
        if(raw_search != null) search = Boolean.parseBoolean(raw_search);
        
        OrderDBContext oDB = new OrderDBContext();
        StudentDBContext sDB = new StudentDBContext();
        TeacherDBContext tDB = new TeacherDBContext();
        ArrayList<Student> students = new ArrayList<>();
        ArrayList<Student> studentsNoSearch;
        
        if(user.getRole() == 3){
            Teacher teacher = tDB.getTeacherByUserId(user.getId());
            studentsNoSearch = sDB.getStudentsByClass(teacher.getClasses().getId());
            request.setAttribute("teacher", teacher);
        }
        else{
            studentsNoSearch = sDB.getStudents();
        }
        
        Hashtable<Integer,Boolean> orders = new Hashtable<>();
        for(Student s: studentsNoSearch){
            boolean status =oDB.getOrder(s.getId(),month,year);
            if(!search || !status){
                students.add(s);
                orders.put(s.getId(),status);
            }
        }
        
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.setAttribute("search", search);
        request.setAttribute("students", students);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("View/order.jsp").forward(request, response);
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
        Account account = (Account) request.getSession().getAttribute("account");
        User user = account.getUser();
        String raw_month = request.getParameter("month");
        String raw_year = request.getParameter("year");
        LocalDate curDate = LocalDate.now();
        int month = curDate.getMonthValue();
        int year = curDate.getYear();
        int day = curDate.getDayOfMonth();
        if(raw_month != null) month = Integer.parseInt(raw_month);
        if(raw_year != null) year = Integer.parseInt(raw_year);
        
        StudentDBContext sDB = new StudentDBContext();
        TeacherDBContext tDB = new TeacherDBContext();
        OrderDBContext oDB = new OrderDBContext();
        ArrayList<Student> students;
        
        if(user.getRole() == 3){
            Teacher teacher = tDB.getTeacherByUserId(user.getId());
            students = sDB.getStudentsByClass(teacher.getClasses().getId());
            request.setAttribute("teacher", teacher);
        }
        else{
            students = sDB.getStudents();
        }
        
        for(Student s : students){
            String param = "isOrder"+Integer.toString(s.getId());
            boolean status = (request.getParameter(param) != null);
            oDB.takeOrder(s.getId(),month,year,status);
        }
        
        response.sendRedirect("order?month="+month+"&year="+year);
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
