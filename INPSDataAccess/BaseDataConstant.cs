using System;
using System.Collections.Generic;
using System.Text;

namespace INPSDataAccess
{
    public class BaseDataConstant
    {   
        internal const string AddCompany = "[dbo].[AddCompanyRecords]";
        internal const string AddInvoice = "[dbo].[AddInvoice]";
        internal const string GetInvoice = "[dbo].[GetInvoices]";
        internal const string GetInvoicesByCompanyID = "[dbo].[GetInvoicesByCompanyID]";
    }
}
