  
  
ALTER PROCEDURE [dbo].[AddInvoice]  
(  
 @CompanyId   INT,  
    @InvoiceDate  DATETIME,  
                  
 @CustomerId   INT,  
 @Customername  NVARCHAR(100),  
 @CustomerStreet  NVARCHAR(100),  
    @CustomerDoorNo  NVARCHAR(20),  
    @CustomerPinCode NVARCHAR(20),  
  
 @ShippingId   INT,  
    @ShippingStreet  NVARCHAR(50),  
    @ShippingDoorNo  NVARCHAR(20),  
    @ShippingPinCode NVARCHAR(20),  
  
 @ItemIds   NVARCHAR(MAX),  
 @CreatedBy   INT,  
 @CreatedOn   DATETIME,  
 @ModifiedBy   INT,  
 @ModifiedOn   DATETIME  
)  
AS  
BEGIN  
 BEGIN TRY    
 SET NOCOUNT ON    
 SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED    
 DECLARE @PurchaseOrderID INT  
 DECLARE @Status NVARCHAR(20),@InvoiceNo NVARCHAR(20)  
  
 --Insert Customer  
 IF NOT EXISTS(SELECT 1 FROM [dbo].[tblCustomer] WHERE id = @CustomerId)  
 BEGIN  
  INSERT INTO [dbo].[tblCustomer] (customername,street,doorno,pincode,createdby,createdon,modifiedby,modifiedon)  
  VALUES (@Customername,@CustomerStreet,@CustomerDoorNo,@CustomerPinCode,@CreatedBy,@CreatedOn,@ModifiedBy,@ModifiedOn)  
  
  SELECT @CustomerId =@@IDENTITY  
 END  
 ELSE  
 BEGIN  
  SELECT @CustomerId = id from  [dbo].[tblCustomer] WHERE id = @CustomerId  
 END  
  
 --Insert Shipping  
 IF NOT EXISTS(SELECT 1 FROM [dbo].[tblShippingAddress] WHERE id = @ShippingId)  
 BEGIN  
  INSERT INTO [dbo].[tblShippingAddress] (shipping_street,shipping_doorno,shipping_pincode,createdby,createdon,modifiedby,modifiedon)  
  VALUES (@ShippingStreet,@ShippingDoorNo,@ShippingPinCode,@CreatedBy,@CreatedOn,@ModifiedBy,@ModifiedOn)  
  
  SELECT @ShippingId =@@IDENTITY  
 END  
 ELSE  
 BEGIN  
  SELECT @ShippingId = id from  [dbo].[tblShippingAddress] WHERE id = @ShippingId  
 END  
  
 --Insert PurchaseOrder  
 INSERT INTO tblPurchaseOrder(createdby,createdon,modifiedby,modifiedon)  
 VALUES(@CreatedBy,@CreatedOn,@ModifiedBy,@ModifiedOn)  
  
 SELECT @PurchaseOrderID = @@IDENTITY  
  
 INSERT INTO tblPurchaseOrderItem (poid,itemid,createdby,createdon,modifiedby,modifiedon)  
 SELECT @PurchaseOrderID as poid,C.ItemId,@CreatedBy,@CreatedOn,@ModifiedBy,@ModifiedOn  
 from [dbo].[tblItems] C  
 WHERE ItemId IN (SELECT  * FROM   STRING_SPLIT(@ItemIds, ','))  
  
 DECLARE @InvoiceNumber NVARCHAR(MAX)  
 SELECT @InvoiceNumber = @CompanyId+REPLACE(CONVERT(CHAR(10), GETDATE(), 103), '/', '')+@PurchaseOrderID  
  
 --Insert tblInvoices  
 INSERT INTO tblInvoices(invoiceno,invoicedate,comp_id,poid,shippingid,customerid,createdby,createdon,modifiedby,modifiedon)  
 VALUES  
 (@InvoiceNumber,@InvoiceDate,@CompanyId,@PurchaseOrderID,@ShippingId,@CustomerId,@CreatedBy,@CreatedOn,@ModifiedBy,@ModifiedOn)  
   
  
 SELECT @Status = [Status],@InvoiceNo =  I.invoiceno   
 FROM tblStatus S   
 JOIN tblCompany C   
 ON S.id = C.comp_status   
 JOIN tblInvoices I   
 ON C.comp_id = I.comp_id  
 WHERE C.comp_id= @CompanyId  
  
 SELECT @Status AS [Status],@InvoiceNo as InvoiceNo  FOR JSON PATH
  
 END TRY    
  BEGIN CATCH    
   DECLARE    
   @ErMessage NVARCHAR(2048),    
   @ErSeverity INT,    
   @ErState INT    
    
    SELECT    
   @ErMessage =  ERROR_MESSAGE(),    
   @ErSeverity = ERROR_SEVERITY(),    
   @ErState = ERROR_STATE()    
    
    RAISERROR (@ErMessage,    
    @ErSeverity,    
    @ErState )    
    
  END CATCH    
END  
  
  