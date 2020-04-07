

USE [INPS]
GO

/****** Object:  Table [dbo].[tblCompany]    Script Date: 05-04-2020 09:45:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblCompany](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[comp_name] [nvarchar](max) NOT NULL,
	[comp_status] [int] NOT NULL,
	[company_id][bigint] NOT NULL,
	[comp_addressid] [int] NOT NULL,
	[createdby] [int] NOT NULL,
	[lastmodifiedby] [int] NOT NULL,
	[lastmodifiedon] [datetime] NOT NULL,
	[createdon] [datetime] NOT NULL,
 CONSTRAINT [PK_tblCompany] PRIMARY KEY CLUSTERED 
(
	[comp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[tblCompany]  WITH CHECK ADD  CONSTRAINT [FK_tblCompany_tblStatus] FOREIGN KEY([comp_status])
REFERENCES [dbo].[tblStatus] ([id])
GO

ALTER TABLE [dbo].[tblCompany] CHECK CONSTRAINT [FK_tblCompany_tblStatus]
GO


