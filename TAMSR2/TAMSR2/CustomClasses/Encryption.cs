using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.IO;


namespace TAMSR2.CustomClasses
{
    public static class Encryption
    {
        public static string Encrypt(string str)
        {
            try
            {
                char[] arr = str.ToCharArray();
                Array.Reverse(arr);
                string temp = new string(arr);
                byte[] encData_byte = System.Text.Encoding.UTF8.GetBytes(temp);
                string encodedData = Convert.ToBase64String(encData_byte);
                return encodedData;
            }
            catch (Exception ex)
            {
                return str;
            }
        }

        public static string Decrypt(string str)
        {
            try
            {
                byte[] decData_byte = System.Convert.FromBase64String(str);
                string decodedData = System.Text.Encoding.UTF8.GetString(decData_byte);
                char[] arr = decodedData.ToCharArray();
                Array.Reverse(arr);
                decodedData = new string(arr);
                return decodedData;
            }
            catch (Exception ex)
            {
                return str;
            }
        }


        public static string Encrypt_AES(string str)
        {
            string original = str;
            try
            {
                using (AesCryptoServiceProvider myAes = new AesCryptoServiceProvider())
                {
                    // Then, we need to turn the password into Key and IV 
                    // We are using salt to make it harder to guess our key
                    // using a dictionary attack - 
                    // trying to guess a password by enumerating all possible words. 
                    PasswordDeriveBytes pdb = new PasswordDeriveBytes("sendo@q33l",
                        new byte[] {0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 
            0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76});
                    byte[] IV = new byte[16];   // match slowaes IV
                    byte[] key = new System.Text.ASCIIEncoding().GetBytes("12345678901234567890123456789012");// match slowaes KEY

                    myAes.BlockSize = 128;
                    myAes.KeySize = 256;
                    myAes.Padding = PaddingMode.PKCS7;
                    myAes.Mode = CipherMode.CBC;

                    // Now get the key/IV and do the encryption using the
                    // function that accepts byte arrays. 
                    // Using PasswordDeriveBytes object we are first getting
                    // 32 bytes for the Key 
                    // (the default Rijndael key length is 256bit = 32bytes)
                    // and then 16 bytes for the IV. 
                    // IV should always be the block size, which is by default
                    // 16 bytes (128 bit) for Rijndael. 
                    // If you are using DES/TripleDES/RC2 the block size is
                    // 8 bytes and so should be the IV size. 
                    // You can also read KeySize/BlockSize properties off
                    // the algorithm to find out the sizes. 
                    myAes.Key = pdb.GetBytes(32);
                    myAes.IV = pdb.GetBytes(16);

                    //myAes.Key = key;
                    // Encrypt the string to an array of bytes. 
                    byte[] encrypted = EncryptStringToBytes_Aes(original, myAes.Key, myAes.IV);
                    // Decrypt the bytes to a string. 
                    string encodStr = Convert.ToBase64String(encrypted);
                    encrypted = EncryptStringToBytes_Aes(encodStr, myAes.Key, myAes.IV);
                    // Decrypt the bytes to a string. 
                    encodStr = Convert.ToBase64String(encrypted);
                    //string roundtrip = DecryptStringFromBytes_Aes(Convert.FromBase64String(encodStr), myAes.Key, myAes.IV);
                    //roundtrip = DecryptStringFromBytes_Aes(Convert.FromBase64String(roundtrip), myAes.Key, myAes.IV);
                    ////Display the original data and the decrypted data.
                    //Console.WriteLine("Original:   {0}", original);
                    //Console.WriteLine("Original:   {0}", encodStr);
                    //Console.WriteLine("Round Trip: {0}", roundtrip);

                    return encodStr;
                }
            }
            catch (Exception ex)
            {
            }
            return str;
        }

        public static string Decrypt_AES(string str)
        {
            string encodStr = str;
            try
            {
                using (AesCryptoServiceProvider myAes = new AesCryptoServiceProvider())
                {
                    // Then, we need to turn the password into Key and IV 
                    // We are using salt to make it harder to guess our key
                    // using a dictionary attack - 
                    // trying to guess a password by enumerating all possible words. 
                    PasswordDeriveBytes pdb = new PasswordDeriveBytes("sendo@q33l",
                        new byte[] {0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 
            0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76});
                    byte[] IV = new byte[16];   // match slowaes IV
                    byte[] key = new System.Text.ASCIIEncoding().GetBytes("12345678901234567890123456789012");// match slowaes KEY

                    myAes.BlockSize = 128;
                    myAes.KeySize = 256;
                    myAes.Padding = PaddingMode.PKCS7;
                    myAes.Mode = CipherMode.CBC;

                    // Now get the key/IV and do the encryption using the
                    // function that accepts byte arrays. 
                    // Using PasswordDeriveBytes object we are first getting
                    // 32 bytes for the Key 
                    // (the default Rijndael key length is 256bit = 32bytes)
                    // and then 16 bytes for the IV. 
                    // IV should always be the block size, which is by default
                    // 16 bytes (128 bit) for Rijndael. 
                    // If you are using DES/TripleDES/RC2 the block size is
                    // 8 bytes and so should be the IV size. 
                    // You can also read KeySize/BlockSize properties off
                    // the algorithm to find out the sizes. 
                    myAes.Key = pdb.GetBytes(32);
                    myAes.IV = pdb.GetBytes(16);

                    //myAes.Key = key;
                    // Encrypt the string to an array of bytes. 
                    //byte[] encrypted = EncryptStringToBytes_Aes(original, myAes.Key, myAes.IV);
                    //// Decrypt the bytes to a string. 
                    //string encodStr = Convert.ToBase64String(encrypted);
                    //encrypted = EncryptStringToBytes_Aes(encodStr, myAes.Key, myAes.IV);
                    // Decrypt the bytes to a string. 
                    //encodStr = Convert.ToBase64String(encrypted);
                    string roundtrip = DecryptStringFromBytes_Aes(Convert.FromBase64String(encodStr), myAes.Key, myAes.IV);
                    roundtrip = DecryptStringFromBytes_Aes(Convert.FromBase64String(roundtrip), myAes.Key, myAes.IV);
                    ////Display the original data and the decrypted data.
                    //Console.WriteLine("Original:   {0}", original);
                    //Console.WriteLine("Original:   {0}", encodStr);
                    //Console.WriteLine("Round Trip: {0}", roundtrip);

                    return roundtrip;
                }
            }
            catch (Exception ex)
            {
            }
            return str;
        }

        static byte[] EncryptStringToBytes_Aes(string plainText, byte[] Key, byte[] IV)
        {
            // Check arguments. 
            if (plainText == null || plainText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("Key");
            byte[] encrypted;
            // Create an AesCryptoServiceProvider object 
            // with the specified key and IV. 
            using (AesCryptoServiceProvider aesAlg = new AesCryptoServiceProvider())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;
                // Create a decrytor to perform the stream transform.
                ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);
                // Create the streams used for encryption. 
                using (MemoryStream msEncrypt = new MemoryStream())
                {
                    using (CryptoStream csEncrypt =
                            new CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter swEncrypt = new StreamWriter(csEncrypt))
                        {
                            //Write all data to the stream.
                            swEncrypt.Write(plainText);
                        }
                        encrypted = msEncrypt.ToArray();
                    }
                }
            }
            // Return the encrypted bytes from the memory stream. 
            return encrypted;
        }
        static string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
        {
            // Check arguments. 
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");
            // Declare the string used to hold 
            // the decrypted text. 
            string plaintext = null;
            // Create an AesCryptoServiceProvider object 
            // with the specified key and IV. 
            using (AesCryptoServiceProvider aesAlg = new AesCryptoServiceProvider())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;
                // Create a decrytor to perform the stream transform.
                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);
                // Create the streams used for decryption. 
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt =
                            new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {
                            // Read the decrypted bytes from the decrypting stream 
                            // and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }
            return plaintext;
        }

    }
}