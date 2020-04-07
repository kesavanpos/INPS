using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using INPSModel;
using INPSServices;
using Microsoft.AspNetCore.Mvc;

namespace INPSAPI.Controllers
{   
    [Route("api/[controller]")]    
    public class CompanyController : ControllerBase
    { 
        [HttpPost("AddCompany")]
        public IActionResult RegisterCompany([FromBody]Company company)
        {
            try
            {
                CompanyService compServices = new CompanyService();
                string resultComp = compServices.RegisterCompany(company);
                return Ok(new { success = true, data = resultComp });
            }
            catch(Exception ex)
            {
                return Ok(new { success = false, error = ex.Message });
            }
        }

        [HttpGet("[action]/{id}")]
        public IActionResult GetCompanyById([FromRoute]string id)
        {
            try
            {
                CompanyService compServices = new CompanyService();
                string resultComp = compServices.GetCompany(id);
                return Ok(new { success = true, data = resultComp });
            }
            catch (Exception ex)
            {
                return Ok(new { success = false, error = ex.Message });
            }
        }
    }
}