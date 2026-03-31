package model;

public class Therapist {
    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private double rating;
    private String availability;
    private String specialty;

    public Therapist() {
    }

    public Therapist(int id, String name, String email, String phone, double rating, String availability,
            String specialty) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.rating = rating;
        this.availability = availability;
        this.specialty = specialty;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }
}
