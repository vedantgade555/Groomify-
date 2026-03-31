package model;

public class Customer {

    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String area;
    private String createdAt;   // ✅ NEW FIELD

    public Customer() {}

    public Customer(int id, String name, String email, String password,
                    String phone, String area) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.area = area;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getArea() { return area; }
    public void setArea(String area) { this.area = area; }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}