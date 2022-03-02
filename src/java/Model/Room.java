/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.ArrayList;

/**
 *
 * @author Linhnvhdev
 */
public class Room {
    private int Id;
    private ArrayList<Student> students;

    public Room() {
        students = new ArrayList<>();
    }

    public int getId() {
        return Id;
    }

    public ArrayList<Student> getStudents() {
        return students;
    }

    public void setId(int Id) {
        this.Id = Id;
    }

    public void setStudents(ArrayList<Student> students) {
        this.students = students;
    }
}
