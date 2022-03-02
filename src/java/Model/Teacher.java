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
public class Teacher extends User {
    private Classes classes;

    public Teacher() {
    }

    public Teacher(Classes classes, int id, String name, boolean sex, String phoneNumber, String gmail) {
        super(id, name, sex, phoneNumber, gmail);
        this.classes = classes;
    }

    public Classes getClasses() {
        return classes;
    }

    public void setClasses(Classes classes) {
        this.classes = classes;
    }
    
    
}
