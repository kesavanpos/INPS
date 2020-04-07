CREATE PROCEDURE [dbo].[GetInvoices] 
(
	@InvoiceNo INT
)
AS
BEGIN

	BEGIN TRY  
	SET NOCOUNT ON  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  

	SELECT 		
		I.invoicedate	AS	InvoiceDate		,
		I.invoiceno		AS	InvoiceNumber	,
		I.TotalAmount	AS	TotalAmount		,

		C.companyname		AS	CompanyName		,
		AD.street		AS	CompanyStreet	,
		AD.doorno		AS	CompanyDoorNo	,
		AD.pincode		AS	CompanyPinCode	,

		CU.customername	AS	CustomerName	,
		CU.street		AS	CustomerStreet	,
		CU.doorno		AS	CustomerDoorNo	,
		CU.pincode		AS	CustomerPinCode	,

		SA.shipping_street	AS ShippingStreet,
		SA.shipping_doorno	AS ShippingDoorNo,
		SA.shipping_pincode	AS ShippingPinCode
	FROM

	[dbo].[tblInvoices] I JOIN
	[dbo].[tblCompany] C ON C.comp_id = I.comp_id
	JOIN
	[dbo].[tblAddress] AD ON AD.id = C.comp_addressid
	JOIN
	[dbo].[tblCustomer] CU ON I.customerid = CU.id
	JOIN
	[dbo].[tblShippingAddress] SA ON I.shippingid = SA.id

	WHERE
	I.invoiceno = @InvoiceNo

	FOR JSON PATH

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


