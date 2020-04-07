using INPSDataAccess;
using INPSModel;
using System;
using System.Collections.Generic;

namespace INPSServices
{
    public class CompanyService
    {
        public string RegisterCompany(Company comp)
        {
            return new CompanyDAO().RegisterCompany(comp);
        }

        public string GetCompany(string id)
        {
            return new CompanyDAO().GetCompany(id);
        }
    }
}
