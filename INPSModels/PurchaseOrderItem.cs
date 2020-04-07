using System;
using System.Collections.Generic;
using System.Text;

namespace INPSModel
{
    public class PurchaseOrderItem : BaseModel
    {
        public int PurchaseOrderItemId { get; set; }

        public int PurchaseOrderId { get; set; }

        public Items[] Items { get; set; }
    }
}
