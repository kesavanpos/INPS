

ALTER PROCEDURE AddCompanyRecords
(
	@CompanyId		INT,
	@CompanyName	NVARCHAR(MAX),
	@CompDoorNo		NVARCHAR(MAX),
	@AddressId		INT			 ,
	@CompStreet		NVARCHAR(MAX),
	@CompPinCode	NVARCHAR(MAX),
	@CreatedBy		INT,
	@LastModifiedBy	INT,
	@LastModifiedOn	DATETIME,
	@CreatedOn		DATETIME
)

AS
BEGIN
	BEGIN TRY  
	SET NOCOUNT ON  
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  

	DECLARE @StatusId INT
	DECLARE @StatusName NVARCHAR(MAX)
	DECLARE @CompID NVARCHAR(MAX)

	IF NOT EXISTS(SELECT 1 FROM dbo.tblAddress WHERE id = @AddressId)
	BEGIN
		INSERT [dbo].[tblAddress](doorno,street,pincode,createdby,createdon,modifiedby,modifiedon)
		VALUES (@CompDoorNo,@CompStreet,@CompPinCode,@CreatedBy,@CreatedOn,@LastModifiedBy,@LastModifiedOn)
		SELECT @AddressId = @@IDENTITY
	END
	ELSE
	BEGIN		
		SELECT @AddressId = id from [dbo].[tblAddress] WHERE Id = @AddressId
	END

	SELECT @StatusId = id FROM [dbo].[tblStatus] WHERE id = 1

	IF NOT EXISTS(SELECT 1 FROM dbo.tblCompany WHERE comp_id = @CompanyId)
	BEGIN
		INSERT 
		[dbo].[tblCompany](			
			comp_status,
			companyno,
			companyname,
			comp_addressid,
			createdby,
			lastmodifiedby,
			lastmodifiedon,
			createdon
		)
		VALUES(			
			@StatusId,
			'',
			@CompanyName,
			@AddressId,
			@CreatedBy,
			@LastModifiedBy,
			@LastModifiedOn,
			@CreatedOn
		)

		SELECT @CompanyId= @@IDENTITY

		UPDATE [dbo].[tblCompany] set companyno=+ @CompanyId+REPLACE(CONVERT(CHAR(9), GETDATE(), 103), '/', '')
		WHERE comp_id = @CompanyId
	END

	SELECT @StatusName = S.[status],@CompID=C.companyno FROM 
			tblStatus S JOIN tblCompany C ON S.id = C.comp_status  
				WHERE C.comp_id = @CompanyId

	SELECT @StatusName as [Status] ,
		   @CompID as CompanyName
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

