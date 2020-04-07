using System;
using System.Collections.Generic;
using System.Text;

namespace INPSModel
{
    public class BaseModel
    {
        public int CreatedBy { get; set; }

        public DateTime CreatedOn { get; set; }

        public DateTime ModifiedOn { get; set; }

        public int ModifiedBy { get; set; }
    }
}
