using System;

namespace INPSModel
{
    public class Invoice : BaseModel
    {
        public int InvoiceId { get; set; }

        public string InvoiceNumber { get; set; }

        public DateTime InvoiceDate { get; set; }

        public PurchaseOrderItem PurchaseOrderItem { get; set; }

        public PurchaseOrder PurchaseOrder { get; set; }

        public Company Company { get; set; }

        public Customer Customer { get; set; }

        public ShippingDetails ShippingDetails { get; set; }

        public string ItemIds { get; set; }
    }
}
