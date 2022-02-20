/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Linhnvhdev
 */
class Teacher extends User {
    private int classId;

    public Teacher() {
    }

    public Teacher(int classId, int id, String name, boolean sex, String phoneNumber, String gmail) {
        super(id, name, sex, phoneNumber, gmail);
        this.classId = classId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }
    
    
}
