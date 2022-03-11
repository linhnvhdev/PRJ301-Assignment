/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dal.AttendanceDBContext;
import Dal.StudentDBContext;
import Model.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Month;
import java.time.Year;
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
public class ReportController extends HttpServlet {

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
        String raw_month = request.getParameter("month");
        String raw_year = request.getParameter("year");
        LocalDate curDate = LocalDate.now();
        int month = curDate.getMonthValue();
        int year = curDate.getYear();
        int day = curDate.getDayOfMonth();
        if(raw_month != null) month = Integer.parseInt(raw_month);
        if(raw_year != null) year = Integer.parseInt(raw_year);
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        StudentDBContext studentDB = new StudentDBContext();
        AttendanceDBContext attendanceDB = new AttendanceDBContext();
        ArrayList<Student> students = studentDB.getStudents();
        Hashtable<Integer,ArrayList<Integer>> attendances = new Hashtable();
        int daysInMonth = Month.of(month).length(true);
        if(month == 2)
            if(Year.isLeap(year)) daysInMonth = 29;
            else daysInMonth = 28;
        for(Student s: students){
            LocalDate startDate = LocalDate.of(year, month,1);
            ArrayList<Integer> status = new ArrayList();
            for(LocalDate date = startDate; date.getMonthValue() == month; date = date.plusDays(1)){
                Date sqlDate = Date.valueOf(date);
                if(attendanceDB.checkAttendance(sqlDate,s.getId())){
                    boolean attendanceStatus = attendanceDB.getAttendance(sqlDate, s.getId());
                    status.add(attendanceStatus ? 1 : 0);
                }
                else status.add(-1);
            }
            attendances.put(s.getId(), status);
        }
        request.setAttribute("daysInMonth", daysInMonth);
        request.setAttribute("attendances", attendances);
        request.setAttribute("students", students);
        request.getRequestDispatcher("View/report.jsp").forward(request, response);
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
