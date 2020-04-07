using System;
using System.Collections.Generic;
using System.Text;

namespace INPSModel
{
    public class Status : BaseModel
    {
        public int Id { get; set; }

        public string CurrentStatus { get; set; }
    }
}
