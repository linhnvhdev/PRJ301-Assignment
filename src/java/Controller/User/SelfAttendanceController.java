/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller.User;

import Dal.AttendanceDBContext;
import Dal.StudentDBContext;
import Dal.UserDBContext;
import Model.Account;
import Model.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Month;
import java.time.Year;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Linhnvhdev
 */
public class SelfAttendanceController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account account = (Account) request.getSession().getAttribute("account");
         String raw_month = request.getParameter("month");
        String raw_year = request.getParameter("year");
        String raw_reportAttendance = request.getParameter("reportAttendance");
        LocalDate curDate = LocalDate.now();
        int month = curDate.getMonthValue();
        int year = curDate.getYear();
        int day = curDate.getDayOfMonth();
        if(raw_month != null) month = Integer.parseInt(raw_month);
        if(raw_year != null) year = Integer.parseInt(raw_year);
        
        int daysInMonth = Month.of(month).length(true);
        if(month == 2)
            if(Year.isLeap(year)) daysInMonth = 29;
            else daysInMonth = 28;
        
        StudentDBContext studentDB = new StudentDBContext();
        AttendanceDBContext attendanceDB = new AttendanceDBContext();
        
        Student s = studentDB.getStudentByUserId(account.getUser().getId());
        ArrayList<Integer> attendances = new ArrayList<>();
        int totalAttendance = 0;
        
        LocalDate startDate = LocalDate.of(year, month,1);
        
        for(LocalDate date = startDate; date.getMonthValue() == month; date = date.plusDays(1)){
                Date sqlDate = Date.valueOf(date);
                if(attendanceDB.checkAttendance(sqlDate,s.getId())){
                    int attendanceStatus = attendanceDB.getAttendance(sqlDate, s.getId())?1:0;
                    attendances.add(attendanceStatus);
                    if(date.getDayOfWeek().getValue() >= 1 && date.getDayOfWeek().getValue() <= 5){
                        totalAttendance += attendanceStatus;
                    }
                }
                else attendances.add(-1);
        }
        
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.setAttribute("daysInMonth", daysInMonth);
        request.setAttribute("attendances", attendances);
        request.setAttribute("totalAttendance", totalAttendance);
        request.setAttribute("student", s);
        
        request.getRequestDispatcher("../View/User/myAttendance.jsp").forward(request, response);
    }

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
        processRequest(request, response);
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
        processRequest(request, response);
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
