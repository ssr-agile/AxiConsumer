using AxiConsumer.Services.Interfaces;
using System.Security.Cryptography;
using System.Text;
using static System.Net.Mime.MediaTypeNames;

public sealed class PasswordService : IPasswordService
{
    public string GenerateRandomPassword(int length = 12)
    {
        const string uppercase = "ABCDEFGHJKLMNPQRSTUVWXYZ";
        const string lowercase = "abcdefghijkmnopqrstuvwxyz";
        const string digits = "23456789";
        //const string special = "!@#$%^&*";
        const string allChars = uppercase + lowercase + digits;
        //const string allChars = uppercase + lowercase + digits + special;

        var result = new char[length];

        result[0] = uppercase[RandomNumberGenerator.GetInt32(uppercase.Length)];
        result[1] = lowercase[RandomNumberGenerator.GetInt32(lowercase.Length)];
        result[2] = digits[RandomNumberGenerator.GetInt32(digits.Length)];
        //result[3] = special[RandomNumberGenerator.GetInt32(special.Length)];

        for (int i = 3; i < result.Length; i++)
        {
            result[i] = allChars[RandomNumberGenerator.GetInt32(allChars.Length)];
        }

        // Shuffle
        for (int i = result.Length - 1; i > 0; i--)
        {
            int j = RandomNumberGenerator.GetInt32(i + 1);
            (result[i], result[j]) = (result[j], result[i]);
        }

        return new string(result);
    }

    // This matches their double-MD5 approach
    public string HashPassword(string password)
    {
        //using (var md5 = MD5.Create())
        //{
        //    // Step 1: Client-side MD5 (what JavaScript sends)
        //    byte[] clientHash = md5.ComputeHash(Encoding.ASCII.GetBytes(password));
        //    string clientHashHex = BitConverter.ToString(clientHash).Replace("-", "").ToLower();

        //    // Step 2: Server-side MD5 (their .NET code)
        //    using (var md5Server = new MD5CryptoServiceProvider())
        //    {
        //        byte[] serverHash = md5Server.ComputeHash(Encoding.ASCII.GetBytes(clientHashHex));
        //        return BitConverter.ToString(serverHash).Replace("-", "").ToLower();
        //    }
        //}

        MD5 md5 = new MD5CryptoServiceProvider();

        //compute hash from the bytes of text  
        md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(password));

        //get hash result after compute it  
        byte[] result = md5.Hash;

        StringBuilder strBuilder = new StringBuilder();
        for (int i = 0; i < result.Length; i++)
        {
            //change it into 2 hexadecimal digits  
            //for each byte  
            strBuilder.Append(result[i].ToString("x2"));
        }

        return strBuilder.ToString();
    }

    // Verify against their format
    public bool VerifyPassword(string password, string storedHash)
    {
        string computedHash = HashPassword(password);

        // Case-insensitive comparison (their code uses lowercase hex)
        return string.Equals(computedHash, storedHash, StringComparison.OrdinalIgnoreCase);
    }
}