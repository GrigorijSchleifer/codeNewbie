# 06.02.2024

### You cannot access non-static members of a class within a static context, such as static method or block. For accessing non-static fields you have to create an instance of the class.


```java
public class HelloWorld {
    String name = "Dobutrex";
    static String static_name = "Dobutrex static";

    public static void main(String[] args) {
        HelloWorld hw = new HelloWorld();

        // non static fields cannot be accessed from inside static methods without an instance 
        System.out.println(hw.name);

        // static field can be accessed by the class without a new instance
        System.out.println(static_name);
    }
}
```

