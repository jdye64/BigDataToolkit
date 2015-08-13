import javax.crypto.Cipher;

/**
 * JCETest check for the availability of the JCE Security Extensions
 *
 * Created by Jeremy Dyer on 8/13/15.
 */
class JCETest {

  public static void main(String[] args) {
  	try {
      int maxKeyLen = Cipher.getMaxAllowedKeyLength("AES");
      System.out.println("JCE is available with a maximum key length of: " + maxKeyLen);
    } catch (Exception e){
      System.out.println("JCE Unlimited Strength was NOT detected ...");
    }
  }

}