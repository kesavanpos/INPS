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
    [ApiController]
    public class InvoiceController : ControllerBase
    {
        [HttpGet]
        public IActionResult Index()
        {
            return Ok();
        }

        [HttpPost("CreateInvoice")]
        public IActionResult AddInvoice([FromBody]Invoice invoice)
        {
            try
            {
                InvoiceService invoiceServices = new InvoiceService();
                string resultComp = invoiceServices.AddInvoice(invoice);
                return Ok(new { success = true, data = resultComp });
            }
            catch (Exception ex)
            {
                return Ok(new { success = false, error = ex.Message });
            }
        }
        
        [HttpGet("[action]/{id}")]
        public IActionResult GetInvoice([FromRoute]string id)
        {
            try
            {
                InvoiceService invoiceServices = new InvoiceService();
                string resultComp = invoiceServices.GetInvoice(id);
                return Ok(new { success = true, data = resultComp });
            }
            catch (Exception ex)
            {
                return Ok(new { success = false, error = ex.Message });
            }
        }
    }
}
