using INPSDataAccess;
using INPSModel;
using System;
using System.Collections.Generic;
using System.Text;

namespace INPSServices
{
    public class InvoiceService 
    {
        public string AddInvoice(Invoice invoice)
        {
            return new InvoiceDAO().AddInvoice(invoice);
        }

        public string GetInvoice(string invoiceNo)
        {
            return new InvoiceDAO().GetInvoice(invoiceNo);
        }
    }
}
