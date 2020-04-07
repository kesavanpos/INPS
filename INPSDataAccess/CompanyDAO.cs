using INPSModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace INPSDataAccess
{
    public class CompanyDAO : BaseDAO
    {
        public string RegisterCompany(Company comp)
        {
            try
            {
                List<SqlParameter> parametersArray = new List<SqlParameter>();

                parametersArray.Add(new SqlParameter("@CompanyId",comp.CompanyId));
                parametersArray.Add(new SqlParameter("@CompanyName", comp.CompanyName));                // Company Address
                parametersArray.Add(new SqlParameter("@CompStreet", comp.CompanyAddress.Street));
                parametersArray.Add(new SqlParameter("@CompDoorNo", comp.CompanyAddress.DoorNo));
                parametersArray.Add(new SqlParameter("@CompPinCode", comp.CompanyAddress.PinCode));
                parametersArray.Add(new SqlParameter("@AddressId", comp.CompanyAddress.AddressId));

                parametersArray.Add(new SqlParameter("@CreatedBy", comp.CreatedBy));
                parametersArray.Add(new SqlParameter("@CreatedOn", DateTime.Now));
                parametersArray.Add(new SqlParameter("@LastModifiedBy", comp.ModifiedBy));
                parametersArray.Add(new SqlParameter("@LastModifiedOn", DateTime.Now));

                return ExecuteProcedureJSON(BaseDataConstant.AddCompany, CommandType.StoredProcedure, parametersArray.ToArray());
            }
            catch(Exception ex)
            {   
                throw;
            }
        }

        public string GetCompany(string id)
        {
            try
            {
                List<SqlParameter> parametersArray = new List<SqlParameter>();
                parametersArray.Add(new SqlParameter("@CompanyId",id));
                return ExecuteProcedureJSON(BaseDataConstant.GetInvoicesByCompanyID, CommandType.StoredProcedure, parametersArray.ToArray());
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
