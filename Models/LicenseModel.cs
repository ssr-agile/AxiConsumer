using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RmqConsumerService.Models
{
    public class LicenseRequest
    {
        public string UserName { get; set; } = string.Empty;
        public string SchemaName { get; set; } = string.Empty;
        public string AppDomain { get; set; } = string.Empty;
    }

    public class LicenseResponse
    {
        // Keeping "sucess" to match your provided JSON payload
        //public bool Success { get; set; }
        public string AuthKey { get; set; }
        public string UserKey { get; set; }
        public string Message { get; set; }
    }
}
