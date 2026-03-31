package model;

public class Service {
    private int id;
    private String serviceName;
    private double price;
    private int duration;

    public Service() {}

    public Service(int id, String serviceName, double price, int duration) {
        this.id = id;
        this.serviceName = serviceName;
        this.price = price;
        this.duration = duration;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
}
