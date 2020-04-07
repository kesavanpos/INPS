using System;
using System.Collections.Generic;
using System.Text;

namespace INPSModel
{
    public class ShippingDetails: BaseModel
    {
        public int ShippingId { get; set; }

        public string ShippingStreet { get; set; }

        public string ShippingPinCode { get; set; }

        public string ShippingDoorNo { get; set; }
    }
}
