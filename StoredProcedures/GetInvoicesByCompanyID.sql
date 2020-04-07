CREATE PROCEDURE [dbo].[GetInvoicesByCompanyID]
(
	@CompanyId INT
)
AS
BEGIN
	BEGIN TRY  
	SET NOCOUNT ON  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  

	SELECT 
		C.companyname,
		I.TotalAmount,
		I.invoiceno
	FROM
	tblCompany C JOIN
	tblInvoices I ON C.comp_id = I.comp_id
	WHERE
	C.comp_id = @CompanyId	
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