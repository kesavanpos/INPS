using System;
using System.Collections.Generic;
using System.Text;

namespace INPSModel
{
    public class Company :BaseModel
    {
        public string CompanyId { get; set; }

        public string CompanyName { get; set; }

        public Status Status { get; set; }

        public CompanyAddress CompanyAddress {get;set;}
    }
}
