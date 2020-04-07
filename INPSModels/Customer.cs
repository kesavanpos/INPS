

namespace INPSModel
{
    public class Customer : BaseModel
    {
        public int CustomerId { get; set; }

        public string CustomerName { get; set; }

        public string Street { get; set; }

        public string DoorNo { get; set; }

        public string PinCode { get; set; }
    }
}
