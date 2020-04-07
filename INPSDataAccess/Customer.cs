using INPSModel;
using System;
using System.Collections.Generic;
using System.Text;

namespace INPSDataAccess
{
    public class Customer : BaseModel
    {
        public string CustomerName { get; set; }

        public string Street { get; set; }

        public string DoorNo { get; set; }

        public string PinCode { get; set; }
    }
}
