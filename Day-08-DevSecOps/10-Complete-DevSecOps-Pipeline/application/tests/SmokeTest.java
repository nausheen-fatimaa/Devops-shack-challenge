public class SmokeTest {
    public static void main(String[] args) {
        if (1 + 1 != 2) {
            throw new IllegalStateException("Smoke test failed");
        }
        System.out.println("Smoke test passed");
    }
}
