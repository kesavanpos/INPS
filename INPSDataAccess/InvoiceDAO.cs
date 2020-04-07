using INPSModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace INPSDataAccess
{
    public class InvoiceDAO : BaseDAO
    {
        public string AddInvoice(Invoice invoice)
        {
            try
            {
                List<SqlParameter> parametersArray = new List<SqlParameter>();

                parametersArray.Add(new SqlParameter("@CompanyId", invoice.Company.CompanyId));
                parametersArray.Add(new SqlParameter("@InvoiceDate", invoice.InvoiceDate));

                parametersArray.Add(new SqlParameter("@CustomerId", invoice.Customer.CustomerId));
                parametersArray.Add(new SqlParameter("@Customername", invoice.Customer.CustomerName));
                parametersArray.Add(new SqlParameter("@CustomerDoorNo", invoice.Customer.DoorNo));
                parametersArray.Add(new SqlParameter("@CustomerStreet", invoice.Customer.Street));
                parametersArray.Add(new SqlParameter("@CustomerPinCode", invoice.Customer.PinCode));

                parametersArray.Add(new SqlParameter("@ShippingId", invoice.ShippingDetails.ShippingId));
                parametersArray.Add(new SqlParameter("@ShippingStreet", invoice.ShippingDetails.ShippingStreet));
                parametersArray.Add(new SqlParameter("@ShippingDoorNo", invoice.ShippingDetails.ShippingDoorNo));
                parametersArray.Add(new SqlParameter("@ShippingPinCode", invoice.ShippingDetails.ShippingPinCode));

                parametersArray.Add(new SqlParameter("@ItemIds", invoice.ItemIds));
                parametersArray.Add(new SqlParameter("@CreatedBy", invoice.CreatedBy));
                parametersArray.Add(new SqlParameter("@CreatedOn", DateTime.Now));
                parametersArray.Add(new SqlParameter("@ModifiedBy", invoice.ModifiedBy));
                parametersArray.Add(new SqlParameter("@ModifiedOn", DateTime.Now));

                return ExecuteProcedureJSON(BaseDataConstant.AddInvoice, CommandType.StoredProcedure, parametersArray.ToArray());
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public string GetInvoice(string invoiceNo)
        {
            List<SqlParameter> parametersArray = new List<SqlParameter>();
            parametersArray.Add(new SqlParameter("@InvoiceNo", invoiceNo));
            return ExecuteProcedureJSON(BaseDataConstant.GetInvoice, CommandType.StoredProcedure, parametersArray.ToArray());
        }
    }
}
