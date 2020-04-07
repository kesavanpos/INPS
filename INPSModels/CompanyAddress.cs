using System;
using System.Collections.Generic;
using System.Text;

namespace INPSModel
{
    public class CompanyAddress : BaseModel
    {
        public int AddressId { get; set; }

        public int CompanyId { get; set; }

        public string Street { get; set; }

        public string PinCode { get; set; }

        public string DoorNo { get; set; }
    }
}
